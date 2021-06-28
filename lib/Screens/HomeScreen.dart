import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:farmx/Screens/AboutUsScreen.dart';
import 'package:farmx/Screens/NewsFeedScreen.dart';
import 'package:farmx/Screens/ToolScreen.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Widgets/Tools/shop.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;

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
                icon: Icon(EvaIcons.shoppingBagOutline),
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
