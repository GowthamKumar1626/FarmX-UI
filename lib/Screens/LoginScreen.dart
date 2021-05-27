import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'dart:ui';

import './SignInScreen.dart';
import '../Widgets/CustomTextField.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggedIn = false;
  // late GoogleSignInAccount _userObj;
  // GoogleSignIn _googleSignIn = GoogleSignIn();

  var _currentSate = MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  getMobileFormWidget(context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50),
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
                  child: CustomTextField(
                    controller: phoneController,
                    textFieldContent: "Phone number",
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _currentSate = MobileVerificationState.SHOW_OTP_FORM_STATE;
            });
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
          height: 10,
        ),
        Text(
          "Forgot Password?",
          style: TextStyle(
            color: Colors.lime.shade500,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 80, right: 10),
                  child: Text(
                    "Create Account here",
                    style: TextStyle(
                      color: Colors.lime.shade500,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                    );
                  },
                  child: Container(
                    child: Text(
                      "Click here",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SignInButton(
            //   Buttons.Google,
            //   text: "Sign up with Google",
            //   onPressed: () {
            //     _googleSignIn.signIn().then((userData) {
            //       setState(() {
            //         _isLoggedIn = true;
            //         _userObj = userData!;
            //       });
            //     }).catchError((error) {
            //       print(error);
            //     });
            //   },
            // ),
          ],
        ),
      ],
    );
  }

  getOTPFormWidget(context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 50),
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
                child: CustomTextField(
                  controller: otpController,
                  textFieldContent: "OTP",
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _isLoggedIn = true;
            });
          },
          child: Container(
            height: 50,
            width: 100,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _isLoggedIn
            ? Column(
                children: [
                  // Image.network(_userObj.photoUrl),
                  // Text(_userName),

                  Container(
                    height: 400,
                    alignment: Alignment.center,
                    child: Text("user@gmail.com"),
                  ),

                  TextButton(
                    child: Text("Log out!"),
                    onPressed: () {
                      setState(() {
                        _isLoggedIn = false;
                        _currentSate =
                            MobileVerificationState.SHOW_MOBILE_FORM_STATE;
                      });
                    },
                  )
                ],
              )
            : Container(
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
                          height: 330,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                  top: 25,
                                  left: 20.0,
                                ),
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
                              Padding(
                                padding: EdgeInsets.all(20.0),
                                child: _currentSate ==
                                        MobileVerificationState
                                            .SHOW_MOBILE_FORM_STATE
                                    ? getMobileFormWidget(context)
                                    : getOTPFormWidget(context),
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
