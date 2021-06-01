import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:farmx/Screens/EditProfileScreen.dart';
import 'package:farmx/Screens/NewsFeedScreen.dart';
import 'package:farmx/Screens/ToolScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UserProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var _pages = [
  NewsFeedScreen(),
  ToolScreen(),
  UserProfileScreen(),
  EditProfileScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 20,
        curve: Curves.decelerate,
        // animationDuration: Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        showElevation: false,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: Icon(EvaIcons.castOutline),
            title: Text('News feed'),
            activeColor: Colors.black,
          ),
          BottomNavyBarItem(
              icon: Icon(EvaIcons.homeOutline),
              title: Text('Home'),
              activeColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(EvaIcons.personOutline),
              title: Text('Account'),
              activeColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(EvaIcons.settingsOutline),
              title: Text('Profile Settings'),
              activeColor: Colors.black),
        ],
      ),
    );
  }
}
