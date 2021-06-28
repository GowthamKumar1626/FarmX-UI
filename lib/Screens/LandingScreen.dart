import 'package:farmx/Screens/HomeScreen.dart';
import 'package:farmx/Screens/SignIn/SignInScreen.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);

    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          if (user == null) {
            return SignInPageScreen.create(context);
          }
          return Provider<Database>(
            create: (_) => FireStoreDatabase(uid: user.uid),
            child: HomeScreen(),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
