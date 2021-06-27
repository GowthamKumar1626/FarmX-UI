import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:farmx/Screens/AboutUsScreen.dart';
import 'package:farmx/Screens/NewsFeedScreen.dart';
import 'package:farmx/Screens/ToolScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:farmx/Widgets/Tools/shop.dart';

class HomeScreen extends StatefulWidget {
  static const id = "home_screen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

var _pages = [
  NewsFeedScreen(),
  ToolScreen(),
  ShopScreen(),
  AboutUsScreen(),
];

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

  @override
  void initState() {
    Firebase.initializeApp();
    if (_auth.currentUser!.isAnonymous) {
      currentIndex = 1;
    }
    super.initState();
  }

  final _auth = auth.FirebaseAuth.instance;
  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (page) {
          setState(() {
            currentIndex = page;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 15,
        curve: Curves.decelerate,
        // animationDuration: Duration(milliseconds: 200),
        backgroundColor: Colors.white,
        showElevation: false,
        selectedIndex: currentIndex,
        onItemSelected: (index) {
          setState(() {
            if (_auth.currentUser!.isAnonymous) {
              currentIndex = 1;
            } else {
              currentIndex = index;
            }
            _pageController.jumpToPage(currentIndex);
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
              icon: Icon(EvaIcons.shoppingBag),
              title: Text('Tools'),
              activeColor: Colors.black),
          BottomNavyBarItem(
              icon: Icon(LineIcons.alternateFile),
              title: Text('About us'),
              activeColor: Colors.black),
        ],
      ),
    );
  }
}
