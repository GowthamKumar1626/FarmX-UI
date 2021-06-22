import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Constants/Errors.dart';
import 'package:farmx/Screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

enum PageSate {
  USERNAME_MAIL_STATE,
  PASSWORD_VERIFY_STATE,
}

class RegistrationScreen extends StatefulWidget {
  static const String id = "registration_screen";

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // late GoogleSignInAccount _userObj;
  // GoogleSignIn _googleSignIn = GoogleSignIn();

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  final _auth = FirebaseAuth.instance;

  var email, password, confirmPassword;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isFarmer = true;

  void createAccount() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');

    if (_key.currentState!.validate()) {
      snackBar(context, 'Creating account', 1);

      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        print(newUser.user);

        Map<String, dynamic> userData = {
          'displayName': null,
          'contactInfo': null,
          'isFarmer': isFarmer,
          'locationData': null,
          'uid': newUser.user!.uid,
        };

        users.doc(newUser.user!.uid).set(userData);

        Navigator.pushNamed(context, HomeScreen.id);
      } catch (error) {
        print('Error: $error');
        switch (error.toString()) {
          case emailInUseError:
            snackBar(context, "Email is in use. Try with a new one", 2);
            break;
          case badlyFormattedEmailError:
            snackBar(context, "Invalid email. Try again!", 2);
            break;
          default:
            snackBar(context, "Error occurred", 2);
            break;
        }
      }
    } else {
      print("Validation failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
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
                      //height: MediaQuery.of(context).size.height,
                      height: MediaQuery.of(context).size.height * 0.50,
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
                                child: Expanded(
                                  child: ListView(
                                    shrinkWrap: true,
                                    // child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          cursorColor: Colors.black,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "It shouldn't be empty";
                                            }
                                            if (value.length < 8 ||
                                                value.length > 32) {
                                              return "Password should contain 8-32 characters";
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
                                        padding: EdgeInsets.all(10),
                                        child: TextFormField(
                                          obscureText: true,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "It shouldn't be empty";
                                            }
                                            if (value.length < 8 ||
                                                value.length > 32) {
                                              return "Password should contain 8-32 characters";
                                            }
                                            if (value != password) {
                                              return "Enter the same password";
                                            }
                                            return null;
                                          },
                                          controller: passwordController,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            labelText: 'Comfirm Password',
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
                                            confirmPassword = value;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                              "Are you farmer?",
                                            ),
                                            Switch(
                                              value: isFarmer,
                                              activeColor: Colors.black,
                                              onChanged: (bool state) {
                                                setState(() {
                                                  isFarmer = state;
                                                });
                                                print(isFarmer);
                                              },
                                            ),
                                          ],
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
                              ),
                              //),
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
