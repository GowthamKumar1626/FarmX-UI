import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:farmx/CommonWidgets/AlertDialogue.dart';
import 'package:farmx/Screens/AboutUsScreen.dart';
import 'package:farmx/Screens/NewsFeedScreen.dart';
import 'package:farmx/Screens/ToolScreen.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Widgets/Tools/shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  int currentIndex = 1;

  Future<void> _signOut(BuildContext context) async {
    final auth = Provider.of<AuthBase>(context, listen: false);
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (error) {
      print(error.message);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: "Logout",
      content: "Are you sure you want to logout?",
      cancelActionText: "Cancel",
      defaultActionText: "Logout",
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  var _pages = [
    NewsFeedScreen(),
    ToolScreen(),
    ShopScreen(),
    AboutUsScreen(),
  ];

  final PageController _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
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
              if (auth.currentUser!.isAnonymous) {
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
        ));
  }
}
