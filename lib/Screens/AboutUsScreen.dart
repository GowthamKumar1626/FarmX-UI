import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

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
          icon: LineIcon(
            LineIcons.alternateSignOut,
            color: kBlack,
          ),
          label: Text(
            "Logout",
            style: kLoginHeading,
          ),
        ),
      ),
    );
  }
}
