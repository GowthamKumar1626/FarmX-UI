abstract class StringValidator {
  bool isValid(String value);
  bool isPasswordCorrect(String password, String confirmPassword);
  bool isValidPhoneNumber(String phoneNumber);
}

class NonEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }

  @override
  bool isPasswordCorrect(String password, String confirmPassword) {
    return password == confirmPassword;
  }

  @override
  bool isValidPhoneNumber(String phoneNumber) {
    return phoneNumber.length == 10;
  }
}

class EmailAndPasswordValidators {
  final StringValidator emailValidator = NonEmptyStringValidator();
  final StringValidator passwordValidator = NonEmptyStringValidator();
  final StringValidator confirmPasswordValidator = NonEmptyStringValidator();

  final StringValidator phoneNumberValidator = NonEmptyStringValidator();

  final String invalidEmailErrorText = "Email can't be empty";
  final String invalidPasswordErrorText = "Password can't be empty";
  final String invalidConfirmPasswordErrorText =
      "Confirm password can't be empty";
  final String passwordNotMatch = "Passwords not match";
  final String invalidPhoneNumberErrorText = "Phone number is badly formatted";
}
