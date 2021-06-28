import 'package:farmx/CommonWidgets/AlertDialogue.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Future<dynamic> showExceptionAlertDialog(
  BuildContext context, {
  required String title,
  required Exception exception,
}) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultActionText: "OK",
    );

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message.toString();
  }
  return exception.toString();
}
