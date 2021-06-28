import 'dart:async';

import 'package:farmx/Screens/SignIn/Models/PhoneSignInModel.dart';
import 'package:farmx/Services/auth.dart';
import 'package:flutter/cupertino.dart';

class PhoneSignInBloc {
  PhoneSignInBloc({required this.auth, required this.context});
  final AuthBase auth;
  final BuildContext context;

  final StreamController<PhoneSignInModel> _modelController =
      StreamController<PhoneSignInModel>();
  Stream<PhoneSignInModel> get modelStream => _modelController.stream;

  PhoneSignInModel _model = PhoneSignInModel();

  void dispose() {
    _modelController.close();
  }

  Future<void> submit() async {
    updateWith(
      isLoading: true,
      submitted: true,
    );
    try {
      await auth.signInWithPhoneNumber(_model.phoneNumber, context, null);
    } catch (error) {
      rethrow;
    }
  }

  void updatePhoneNumber(String phoneNumber) =>
      updateWith(phoneNumber: phoneNumber);

  void updateWith({
    var phoneNumber,
    var isLoading,
    var submitted,
  }) {
    _model = _model.copyWith(
      phoneNumber: phoneNumber,
      isLoading: isLoading,
      submitted: submitted,
    );
    _modelController.add(_model);
  }
}
