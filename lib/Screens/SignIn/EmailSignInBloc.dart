import 'dart:async';

import 'package:farmx/Screens/SignIn/Models/EmailSignInModel.dart';
import 'package:farmx/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EmailSignInBloc {
  EmailSignInBloc({required this.auth});
  final AuthBase auth;

  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;

  EmailSignInModel _model = EmailSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(
      isLoading: true,
      submitted: true,
    );
    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        if (_model.password != _model.confirmPassword)
          throw FirebaseAuthException(
              code: "PASSWORD_MISMATCH", message: "Passwords are not match");
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (error) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;
    updateWith(
      email: '',
      password: '',
      confirmPassword: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
  void updateConfirmPassword(String confirmPassword) =>
      updateWith(confirmPassword: confirmPassword);

  void updateWith({
    var email,
    var password,
    var confirmPassword,
    var formType,
    var isLoading,
    var submitted,
  }) {
    _model = _model.copyWith(
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );
    _modelController.add(_model);
  }
}
