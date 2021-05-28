import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'CategoryScreen.dart';
import 'RegistrationScreen.dart';

class LoginScreen extends StatefulWidget {
  static const id = "login_screen";

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background-3.jpeg"),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "Login to your account",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
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
                                          color:
                                              Color.fromRGBO(92, 148, 71, 0.2),
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
                                          keyboardType:
                                              TextInputType.emailAddress,
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
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                        height: 20,
                                        padding: EdgeInsets.only(left: 10),
                                        child: TextField(
                                          obscureText: true,
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
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () async {
                                    print(email);
                                    try {
                                      final user = await _auth
                                          .signInWithEmailAndPassword(
                                              email: email, password: password);
                                      // ignore: unnecessary_null_comparison
                                      if (user != null) {
                                        Navigator.pushNamed(
                                            context, CategoryScreen.id);
                                      } else {
                                        print("No User Found");
                                      }
                                    } catch (error) {
                                      print(error);
                                    }
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
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    padding: EdgeInsets.only(right: 8),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, RegistrationScreen.id);
                                      },
                                      child: Text(
                                        "Forget password?",
                                        style: TextStyle(
                                          color: Colors.lime.shade500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, RegistrationScreen.id);
                                  },
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
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
      ),
    );
  }
}
