import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _auth = auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton.icon(
          onPressed: () async {
            try {
              await _auth.signOut();
              Navigator.pushNamed(context, LoginScreen.id);
            } catch (error) {
              print(error);
            }
          },
          icon: Icon(Icons.settings_outlined),
          label: Text(
            "Logout",
            style: kLoginHeading,
          ),
        ),
      ),
    );
  }
}
