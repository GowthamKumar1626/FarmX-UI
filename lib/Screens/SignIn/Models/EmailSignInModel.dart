import 'package:farmx/Screens/SignIn/validators.dart';

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInModel with EmailAndPasswordValidators {
  EmailSignInModel({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

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

  EmailSignInModel copyWith({
    var email,
    var password,
    var confirmPassword,
    var formType,
    var isLoading,
    var submitted,
  }) {
    return EmailSignInModel(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
