import 'dart:async';

import 'package:farmx/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

class SignInManager {
  SignInManager({
    required this.auth,
    required this.isLoading,
  });
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  Future<User?> _signIn(Future<User?> Function() signInMethod) async {
    try {
      isLoading.value = true;
      await signInMethod();
    } catch (error) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User?> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User?> signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);
}
