import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Constants/Crops.dart';
import 'package:farmx/Screens/HomeScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/CropInfoScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/GeneralInfoScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/PrivacySettingsScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class UserProfileScreen extends StatefulWidget {
  static const id = "user_profile";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _auth = auth.FirebaseAuth.instance;
  var displayName, isFarmer, uid;

  @override
  void initState() {
    Firebase.initializeApp();
    uid = _auth.currentUser!.uid;
    fetchUserDetails(uid);
    super.initState();
  }

  fetchUserDetails(uid) async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    setState(() {
      displayName = variable.data()!["displayName"];
      isFarmer = variable.data()!["isFarmer"];
      print(displayName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkPrimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
        ),
        backgroundColor: kDarkPrimaryColor,
        elevation: 0.0,
        title: Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                fetchUserDetails(uid);
              });
            },
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                Positioned(
                  top: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height * 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Center(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // border: Border.all(
                          //   width: 4,
                          //   color: Theme.of(context).scaffoldBackgroundColor,
                          // ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 10),
                              spreadRadius: 2,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/user.JPG"),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.2,
                  left: 25,
                  right: 25,
                  child: Column(
                    children: <Widget>[
                      Text(
                        displayName == null
                            ? "Hey User"
                            : displayName.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                        _auth.currentUser!.email.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto',
                          fontSize: 15.0,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                GeneralInfoScreen.id,
                              );
                            },
                            child: ProfileListItem(
                              icon: LineIcons.infoCircle,
                              text: "General Info",
                            ),
                          ),
                          isFarmer == true
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      CropInfoScreen.id,
                                    );
                                  },
                                  child: ProfileListItem(
                                    icon: LineIcons.tools,
                                    text: "Crop Info",
                                  ),
                                )
                              : Container(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PrivacySettingsScreen.id,
                              );
                            },
                            child: ProfileListItem(
                              icon: LineIcons.userShield,
                              text: "Privacy",
                            ),
                          ),
                          GestureDetector(
                            child: ProfileListItem(
                              icon: LineIcons.history,
                              text: "Purchase History",
                            ),
                          ),
                          GestureDetector(
                            child: ProfileListItem(
                              icon: LineIcons.questionCircle,
                              text: "Help & Support",
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// BuildCropInfoCard
class CropsCultivatedContainer extends StatelessWidget {
  final int index;

  CropsCultivatedContainer({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(crops[index].imgPath),
        ),
      ),
    );
  }
}

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileListItem({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      margin: EdgeInsets.only(bottom: 15),
      // margin: EdgeInsets.symmetric(
      //   horizontal: kSpacingUnit * 4,
      // ).copyWith(
      //   bottom: kSpacingUnit * 2,
      // ),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit * 2),
        color: kDarkSecondaryColor,
      ),
      child: Row(
        children: <Widget>[
          LineIcon(
            this.icon,
            color: Colors.white,
            size: kSpacingUnit * 2.5,
          ),
          SizedBox(width: kSpacingUnit * 1.5),
          Text(
            this.text,
            style: kTitleTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: kLightSecondaryColor,
            ),
          ),
          Spacer(),
          LineIcon(
            LineIcons.angleRight,
            size: kSpacingUnit * 2.5,
            color: kAccentColor,
          ),
        ],
      ),
    );
  }
}
