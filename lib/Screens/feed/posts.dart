import 'dart:math';

import 'package:farmx/Screens/feed/commons/const.dart';
import 'package:farmx/Screens/feed/userProfile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'commons/utils.dart';
//import 'controllers/FBCloudMessaging.dart';
import 'threadMain.dart';

class PostsScreen extends StatefulWidget {
  @override
  _PostsScreenState createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  MyProfileData? myData;

  bool _isLoading = false;

  @override
  void initState() {
    //FBCloudMessaging.instance.takeFCMTokenWhenAppLaunch();
    // FBCloudMessaging.instance.initLocalNotification();
    _tabController = new TabController(length: 2, vsync: this);
    _tabController!.addListener(_handleTabSelection);
    _takeMyData();
    super.initState();
  }

  Future<void> _takeMyData() async {
    setState(() {
      _isLoading = true;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String myThumbnail;
    String myName;
    if (prefs.get('myThumbnail') == null) {
      String tempThumbnail = iconImageList[Random().nextInt(50)];
      prefs.setString('myThumbnail', tempThumbnail);
      myThumbnail = tempThumbnail;
    } else {
      myThumbnail = prefs.get('myThumbnail') as String;
    }

    if (prefs.get('myName') == null) {
      String tempName = Utils.getRandomString(8);
      prefs.setString('myName', tempName);
      myName = tempName;
    } else {
      myName = prefs.get('myName') as String;
    }

    setState(() {
      myData = MyProfileData(
        myThumbnail: myThumbnail,
        myName: myName,
        myLikeList: prefs.getStringList('likeList'),
        myLikeCommnetList: prefs.getStringList('likeCommentList'),
        myFCMToken: prefs.getString('FCMToken'),
      );
    });

    setState(() {
      _isLoading = false;
    });
  }

  void _handleTabSelection() => setState(() {});

  void onTabTapped(int index) {
    setState(() {
      _tabController!.index = index;
    });
  }

  void updateMyData(MyProfileData newMyData) {
    setState(() {
      myData = newMyData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(controller: _tabController, children: [
            ThreadMain(
              myData: myData,
              updateMyData: updateMyData,
            ),
            UserProfile(
              myData: myData,
              updateMyData: updateMyData,
            ),
          ]),
          Utils.loadingCircle(_isLoading),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _tabController!.index,
        selectedItemColor: Colors.amber[900],
        unselectedItemColor: Colors.grey[800],
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.people),
            title: new Text('Thread'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.account_circle),
            title: new Text('Profile'),
          ),
        ],
      ),
    );
  }
}
