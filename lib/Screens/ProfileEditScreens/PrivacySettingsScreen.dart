import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Constants/Errors.dart';
import 'package:farmx/Screens/UserScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class PrivacySettingsScreen extends StatefulWidget {
  @override
  _PrivacySettingsScreenState createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  // final _key = GlobalKey<FormState>();
  String? fullName;
  String? number;
  String? location;

  bool isLocationShared = false;
  bool isImageShareAccessProvided = false;

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkPrimaryColor,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Privacy Settings",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        // padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text(
                                "Do you want to share the images captured by you for pest analysis",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left),
                          ],
                        ),
                      ),
                      Switch(
                        value: isImageShareAccessProvided,
                        activeColor: Colors.black,
                        onChanged: (bool state) {
                          setState(() {
                            isImageShareAccessProvided = state;
                          });
                          print(
                              "isImageShareAccessProvided: $isImageShareAccessProvided");
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        // padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: new Column(
                          children: <Widget>[
                            new Text(
                                "Share your location details to gain access for co-farming feature",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left),
                          ],
                        ),
                      ),
                      Switch(
                        value: isLocationShared,
                        activeColor: Colors.black,
                        onChanged: (bool state) {
                          setState(() {
                            isLocationShared = state;
                          });
                          print("isLocationShared: $isLocationShared");
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => kDarkPrimaryColor,
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      userGeneralInfo(fullName!, _auth.currentUser!.uid);
                      snackBar(context, "Changes updated. Reload the page", 2);
                      Timer(Duration(seconds: 2), () {
                        // 5s over, navigate to a new page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserScreen(),
                          ),
                        );
                      });
                    },
                    child: Text(
                      "Save changes",
                      style: TextStyle(fontSize: 15),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith(
                        (states) => kDarkPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> userGeneralInfo(String displayName, var uid) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');

  users.add({
    'displayName': displayName,
    'uid': uid,
  });

  final _auth = FirebaseAuth.instance;
  _auth.currentUser!.updateProfile(displayName: displayName);
  await _auth.currentUser!.reload();
  return;
}
