import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Spacer(),
          Container(
            child: Center(
              child: Text(
                "This is user account creation page",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text(
                "Back",
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
