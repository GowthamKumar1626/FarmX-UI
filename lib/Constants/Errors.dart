import 'package:flutter/material.dart';

const userDeleteError =
    "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.";
const passwordIncorrectError =
    "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.";

const badlyFormattedEmailError =
    "[firebase_auth/invalid-email] The email address is badly formatted.";
const emailInUseError =
    "[firebase_auth/email-already-in-use] The email address is already in use by another account.";

dynamic snackBar(context, message, duration) {
  return (ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ),
  ));
}
