import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:farmx/Screens/NewsFeedScreen.dart';
import 'package:farmx/Screens/ToolScreen.dart';
import 'package:farmx/Screens/UserProfileScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var _pages = [
  NewsFeedScreen(),
  ToolScreen(),
  UserProfileScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      bottomNavigationBar: BottomNavyBar(
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
        ],
      ),
    );
  }
}
