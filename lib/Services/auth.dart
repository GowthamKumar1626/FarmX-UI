import 'package:farmx/CommonWidgets/ExceptionAlertDialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sms_autofill/sms_autofill.dart';

abstract class AuthBase {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> signInAnonymously();
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> signInWithPhoneNumber(
      String phoneNumber, BuildContext context, UserCredential? userCredential);
  Future<User?> createUserWithEmailAndPassword(String email, String password);
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _codeController = TextEditingController();

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredentials = await _firebaseAuth.signInAnonymously();
    return userCredentials.user;
  }

  @override
  Future<User?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredentials =
        await _firebaseAuth.signInWithCredential(EmailAuthProvider.credential(
      email: email,
      password: password,
    ));
    return userCredentials.user;
  }

  @override
  Future<User?> signInWithPhoneNumber(String phoneNumber, BuildContext context,
      UserCredential? userCredential) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber,
      verificationCompleted: (AuthCredential credential) async {
        userCredential = await _firebaseAuth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseException error) {
        showExceptionAlertDialog(
          context,
          title: "Verification Failed",
          exception: error,
        );
      },
      codeSent: (String verificationId, int? forceResendingToken) => _codeSent(
        verificationId,
        forceResendingToken,
        context,
        userCredential,
      ),
      timeout: const Duration(seconds: 120),
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return userCredential?.user;
  }

  @override
  Future<User?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final userCredentials = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredentials.user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredentials = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
              idToken: googleAuth.idToken, accessToken: googleAuth.accessToken),
        );
        return userCredentials.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: "Missing google id token",
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: "Sign in aborted by user",
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  void _codeSent(
    String verificationId,
    int? forceResendingToken,
    BuildContext context,
    UserCredential? userCredential,
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter OTP"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: PinFieldAutoFill(
                  codeLength: 6,
                  keyboardType: TextInputType.number,
                  controller: _codeController,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Change number"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm"),
              onPressed: () => _verifyOTP(
                verificationId,
                forceResendingToken,
                context,
                userCredential,
              ),
            ),
          ],
        );
      },
    );
  }

  void _verifyOTP(
    String verificationId,
    int? forceResendingToken,
    BuildContext context,
    UserCredential? userCredential,
  ) async {
    try {
      final code = _codeController.text.trim();
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);

      userCredential = await _firebaseAuth.signInWithCredential(credential);
      Navigator.of(context).pop();
    } on Exception catch (error) {
      showExceptionAlertDialog(
        context,
        title: "Sign in Failed",
        exception: error,
      );
    }
  }
}
