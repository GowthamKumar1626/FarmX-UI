import 'package:farmx/Screens/SignIn/Models/EmailSignInModel.dart';
import 'package:farmx/Screens/SignIn/validators.dart';
import 'package:farmx/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  EmailSignInChangeModel({
    required this.auth,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final AuthBase auth;
  String email;
  String password;
  String confirmPassword;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  Future<void> submit() async {
    updateWith(
      isLoading: true,
      submitted: true,
    );
    try {
      if (formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(email, password);
      } else {
        if (password != confirmPassword)
          throw FirebaseAuthException(
              code: "PASSWORD_MISMATCH", message: "Passwords are not match");
        await auth.createUserWithEmailAndPassword(email, password);
      }
    } catch (error) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? "Sign in"
        : "Create an account";
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? "Need an account? Register"
        : "Have an account? Sign in";
  }

  bool get canSubmit {
    return formType == EmailSignInFormType.signIn
        ? emailValidator.isValid(email) &&
            passwordValidator.isValid(password) &&
            !isLoading
        : emailValidator.isValid(email) &&
            passwordValidator.isValid(password) &&
            confirmPasswordValidator.isValid(confirmPassword) &&
            confirmPasswordValidator.isPasswordCorrect(
                password, confirmPassword) &&
            !isLoading;
  }

  String? get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String? get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String? get passwordConfirmErrorText {
    bool validError =
        submitted && !confirmPasswordValidator.isValid(confirmPassword);
    bool missMatchError = submitted &&
        !confirmPasswordValidator.isPasswordCorrect(password, confirmPassword);
    return validError
        ? invalidConfirmPasswordErrorText
        : missMatchError
            ? passwordNotMatch
            : null;
  }

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
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
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.confirmPassword = confirmPassword ?? this.confirmPassword;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
