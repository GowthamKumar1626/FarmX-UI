import 'dart:ui';

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Constants/Crops.dart';
import 'package:farmx/Screens/ProfileEditingScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';

class UserProfileScreen extends StatefulWidget {
  static const id = "user_profile";
  final heroTag = "HeroTag";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  final _auth = auth.FirebaseAuth.instance;

  @override
  void initState() {
    Firebase.initializeApp();
    _auth.currentUser!.reload();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkPrimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
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
            onPressed: () {},
            icon: Icon(
              Icons.edit,
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
                  height: MediaQuery.of(context).size.height - 82.0,
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
                    height: MediaQuery.of(context).size.height - 100.0,
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
                        _auth.currentUser!.displayName == null
                            ? "Hey User"
                            : _auth.currentUser!.displayName.toString(),
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
                          ProfileListItem(
                            icon: LineIcons.infoCircle,
                            onPressed: () {
                              print("General Info");
                              Navigator.pushNamed(
                                  context, ProfileEditingScreen.id);
                            },
                            text: "General Info",
                          ),
                          ProfileListItem(
                            icon: LineIcons.tools,
                            onPressed: () {
                              print("Click");
                            },
                            text: "Crop Info",
                          ),
                          ProfileListItem(
                            icon: LineIcons.userShield,
                            onPressed: () {
                              print("Click");
                            },
                            text: "Privacy",
                          ),
                          ProfileListItem(
                            icon: LineIcons.history,
                            onPressed: () {
                              print("Click");
                            },
                            text: "Purchase History",
                          ),
                          ProfileListItem(
                            icon: LineIcons.questionCircle,
                            onPressed: () {
                              print("Click");
                            },
                            text: "Help & Support",
                          ),
                          ProfileListItem(
                            icon: LineIcons.alternateFile,
                            onPressed: () {
                              print("Click");
                            },
                            text: "About us",
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
  final Function() onPressed;

  const ProfileListItem({
    required this.icon,
    required this.text,
    required this.onPressed,
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
          IconButton(
            icon: LineIcon(
              LineIcons.angleRight,
              size: kSpacingUnit * 2.5,
              color: kAccentColor,
            ),
            onPressed: this.onPressed,
          ),
        ],
      ),
    );
  }
}

//Location Getter

Future<LocationData> locationGetter() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return Future.error('Location service not enabled');
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return Future.error('Location permissions are denied');
    }
  }

  _locationData = await location.getLocation();
  return _locationData;
}
