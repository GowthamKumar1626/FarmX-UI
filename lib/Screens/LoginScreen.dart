import 'dart:ui';

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Constants/Errors.dart';
import 'package:farmx/Screens/HomeScreen.dart';
import 'package:farmx/Screens/RegistrationScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _auth = auth.FirebaseAuth.instance;

  String email = "";
  String password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void validateLogin() async {
    if (_key.currentState!.validate()) {
      snackBar(context, "Fetching Details", 1);
      try {
        final resultEmailSignIn = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        final userEmailSignIn = resultEmailSignIn.user;
        // ignore: unnecessary_null_comparison
        if (userEmailSignIn != null) {
          Navigator.pushNamed(context, HomeScreen.id);
        } else {
          print("No User Found");
        }
      } catch (error) {
        print(error);

        switch (error.toString()) {
          case userDeleteError:
            snackBar(
                context, "You're not an user. Please create an account", 2);
            break;
          case passwordIncorrectError:
            snackBar(context, "Incorrect Password. Try again!", 2);
            break;
          default:
            snackBar(context, "Error occurred!", 2);
            break;
        }
      }
    } else {
      print("Validation failed");
    }
  }

  void anonymousSignIn() async {
    snackBar(context, 'SigningIn anonymously', 1);

    try {
      final anonymousSignInResult = await _auth.signInAnonymously();
      final anonymousUser = anonymousSignInResult.user;

      if (anonymousUser != null) {
        Navigator.pushNamed(context, HomeScreen.id);
      }
    } catch (error) {
      print(error);
      snackBar(context, 'Error has occurred', 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/LoginScreen-1.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              Spacer(),
              Container(
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
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.5),
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
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        cursorColor: Colors.black,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Fill your email';
                                          }
                                          if (value.contains('@') == false) {
                                            return 'Invalid Email ID';
                                          }
                                          return null;
                                        },
                                        controller: emailController,
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
                                                color: Colors.black,
                                                width: 1.0),
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
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "It shouldn't be empty";
                                          }
                                          return null;
                                        },
                                        controller: passwordController,
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
                                                color: Colors.black,
                                                width: 1.0),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: TextButton(
                                              child: Text(
                                                "Create account",
                                                style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushNamed(context,
                                                    RegistrationScreen.id);
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: ElevatedButton(
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateColor
                                                      .resolveWith(
                                                          (states) => kBlack),
                                            ),
                                            onPressed: validateLogin,
                                          ),
                                        ),
                                      ],
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
                                            icon: Image.asset(
                                                "assets/icons/anonymous.png"),
                                            onPressed: anonymousSignIn,
                                          ),
                                          IconButton(
                                            icon: Image.asset(
                                                "assets/icons/icons8-google.png"),
                                            onPressed: () async {},
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
            ],
          ),
        ],
      ),
    );
  }
}
