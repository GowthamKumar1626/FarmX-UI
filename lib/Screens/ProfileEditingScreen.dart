import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Constants/Errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ProfileEditingScreen extends StatefulWidget {
  static const id = "profile_edit";

  @override
  _ProfileEditingScreenState createState() => _ProfileEditingScreenState();
}

class _ProfileEditingScreenState extends State<ProfileEditingScreen> {
  final _key = GlobalKey<FormState>();
  String? fullName;
  String? number;
  String? location;

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
          "Edit Profile",
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
                      "Edit General Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _key,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          keyboardType: TextInputType.name,
                          cursorColor: Colors.black,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Full name',
                            labelStyle: kLabelStyleDefault,
                            prefixIcon: Icon(
                              LineIcons.alternateIdentificationCard,
                              color: kBlack,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                          onChanged: (value) {
                            fullName = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Contact-Info',
                            labelStyle: kLabelStyleDefault,
                            prefixIcon: Icon(
                              LineIcons.phone,
                              color: kBlack,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                          onChanged: (value) {
                            number = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          cursorColor: Colors.black,
                          validator: (value) {
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Location',
                            labelStyle: kLabelStyleDefault,
                            prefixIcon: Icon(
                              LineIcons.mapPin,
                              color: kBlack,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                          ),
                          onChanged: (value) {
                            location = value;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
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
                              onPressed: () {
                                userGeneralInfo(
                                    fullName!, _auth.currentUser!.uid);
                                snackBar(context, "Changes updated", 2);
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
                            )
                          ],
                        ),
                      ],
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
