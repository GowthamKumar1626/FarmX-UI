import 'package:farmx/Screens/SignIn/validators.dart';

class PhoneSignInModel with EmailAndPasswordValidators {
  PhoneSignInModel({
    this.phoneNumber = '',
    this.submitted = false,
    this.isLoading = false,
  });

  final String phoneNumber;
  final bool isLoading;
  final bool submitted;

  String get primaryButtonText {
    return "Confirm";
  }

  String? get phoneNumberErrorText {
    bool showErrorText =
        submitted && !phoneNumberValidator.isValidPhoneNumber(phoneNumber);
    return showErrorText ? invalidEmailErrorText : null;
  }

  PhoneSignInModel copyWith({
    var phoneNumber,
    var isLoading,
    var submitted,
  }) {
    return PhoneSignInModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
