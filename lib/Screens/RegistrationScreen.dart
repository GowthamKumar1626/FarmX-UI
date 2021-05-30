import 'dart:ui';

import 'package:farmx/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'HomeScreen.dart';
import 'LoginScreen.dart';

enum MobileVerificationState {
  SHOW_EMAIL_FORM_STATE,
  SHOW_PASSWORD_FORM_STATE,
}

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // late GoogleSignInAccount _userObj;
  // GoogleSignIn _googleSignIn = GoogleSignIn();

  var _currentSate = MobileVerificationState.SHOW_EMAIL_FORM_STATE;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String email = "";
  String password = "";

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  getEmailFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              "Create an account",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(92, 148, 71, 0.2),
                  blurRadius: 20.0,
                  offset: Offset(0, 10),
                ),
              ]),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Email",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            print(email);
            setState(
              () {
                _currentSate = MobileVerificationState.SHOW_PASSWORD_FORM_STATE;
              },
            );
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(201, 184, 24, 1),
                Color.fromRGBO(201, 184, 24, 0.6),
              ]),
            ),
            child: Center(
              child: Text(
                "Click Here",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Existing user?",
              style: TextStyle(
                color: Colors.lime.shade500,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.id);
              },
              child: Text(
                "Click here",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  getPasswordFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Password",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(92, 148, 71, 0.2),
                  blurRadius: 20.0,
                  offset: Offset(0, 10),
                ),
              ]),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade100,
                    ),
                  ),
                ),
              ),
              Container(
                height: 20,
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                    hintStyle: TextStyle(
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () async {
            setState(() {
              showSpinner = true;
            });
            try {
              final newUser = await _auth.createUserWithEmailAndPassword(
                  email: email, password: password);

              if (newUser != null) { // ignore: unnecessary_null_comparison
                // ignore: unnecessary_null_comparison
                Navigator.pushNamed(context, HomeScreen.id);
              }

              setState(() {
                showSpinner = false;
              });
            } catch (error) {
              print('Error: $error');
              Navigator.pushNamed(context, RegistrationScreen.id);
            }
          },
          child: Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: LinearGradient(colors: [
                Color.fromRGBO(201, 184, 24, 1),
                Color.fromRGBO(201, 184, 24, 0.6),
              ]),
            ),
            child: Center(
              child: Text(
                "Verify",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _currentSate = MobileVerificationState.SHOW_EMAIL_FORM_STATE;
            });
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background-2.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 22),
              decoration: BoxDecoration(
                boxShadow: ([
                  BoxShadow(
                    blurRadius: 24.0,
                    spreadRadius: 16.0,
                    color: Colors.black.withOpacity(0.4),
                  )
                ]),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 25.0,
                    sigmaY: 25.0,
                  ),
                  child: Container(
                    height: 350,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(16.0),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(20.0),
                          child: _currentSate ==
                                  MobileVerificationState.SHOW_EMAIL_FORM_STATE
                              ? getEmailFormWidget(context)
                              : getPasswordFormWidget(context),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
