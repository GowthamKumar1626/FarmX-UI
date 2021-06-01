import 'dart:ui';

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // late GoogleSignInAccount _userObj;
  // GoogleSignIn _googleSignIn = GoogleSignIn();

  final _key = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String email = "";
  String password = "";

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  String validateEmail(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return "";
  }

  String validatePassword(value) {
    if (value == null) {
      return "It cannot be empty";
    } else if (value.length < 8 && value.length > 32) {
      return "Password should be length of 8-32 characters";
    } else {
      return "";
    }
  }

  void createAccount() async {
    if (_key.currentState!.validate()) {
      // If the form is valid, display a Snackbar.
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Data is in processing.')));
    } else {
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        if (newUser != null) {
          // ignore: unnecessary_null_comparison
          // ignore: unnecessary_null_comparison
          Navigator.pushNamed(context, HomeScreen.id);
        }
      } catch (error) {
        print('Error: $error');
        Navigator.pushNamed(context, RegistrationScreen.id);
      }
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
                                    "Create account",
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
                                        validator: validateEmail,
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
                                                color: Colors.black,
                                                width: 1.0),
                                          ),
                                        ),
                                        onChanged: (value) {
                                          password = value;
                                        },
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
                                                "Existing user",
                                                style: TextStyle(
                                                  color: kBlack,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 150,
                                          child: ElevatedButton(
                                            child: Text(
                                              "Create",
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
                                            onPressed: createAccount,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text("Create account using:"),
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
                                            onPressed: () {},
                                          ),
                                          IconButton(
                                            icon: Image.asset(
                                                "assets/icons/icons8-google.png"),
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
            ],
          ),
        ],
      ),
    );
  }
}
