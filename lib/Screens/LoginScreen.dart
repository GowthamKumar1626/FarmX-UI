import 'dart:ui';

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  final _key = GlobalKey<FormState>();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _auth = auth.FirebaseAuth.instance;

  String validateEmail(value) {
    if (value == null) {
      return "";
    } else if (value.contains('@') == false) {
      return 'Invalid Email';
    } else {
      return 'Please provide your email';
    }
  }

  String validatePassword(value) {
    if (value == null) {
      return "";
    } else {
      return 'It cannot be empty';
    }
  }

  void validateLogin() async {
    if (_key.currentState!.validate()) {
      print("Not Validated");
    } else {
      try {
        final user = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        // ignore: unnecessary_null_comparison
        if (user != null) {
          Navigator.pushNamed(context, HomeScreen.id);
        } else {
          print("No User Found");
        }
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/LoginScreen-1.png"),
            fit: BoxFit.cover,
          ),
        ),
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
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                child: Stack(
                  alignment: AlignmentDirectional.topStart,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Login to your account",
                              style: kLoginHeading,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: _key,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor: Colors.black,
                                  validator: validateEmail,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: kLabelStyleDefault,
                                    prefixIcon: Icon(
                                      Icons.mail,
                                      color: kBlack,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    email = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: TextFormField(
                                  obscureText: true,
                                  validator: validatePassword,
                                  cursorColor: Colors.black,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: kLabelStyleDefault,
                                    prefixIcon: Icon(
                                      Icons.admin_panel_settings,
                                      color: kBlack,
                                    ),
                                    border: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 1.0),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    password = value;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Text("Forgot password?"),
                                ),
                              ),
                              SizedBox(
                                width: 200,
                                child: ElevatedButton(
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateColor.resolveWith(
                                            (states) => kBlack),
                                  ),
                                  onPressed: validateLogin,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Login Options:"),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(
                                        Icons.mail,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.phone,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.attach_email,
                                      ),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.admin_panel_settings,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
