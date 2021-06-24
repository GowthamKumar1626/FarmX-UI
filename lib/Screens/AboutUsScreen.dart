import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Screens/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  final _auth = auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkPrimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
        ),
        backgroundColor: kDarkPrimaryColor,
        elevation: 0.0,
        title: Text(
          "About Us",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.080,
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
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 25,
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                      ),
                      Center(
                        child: TextButton.icon(
                          onPressed: () async {
                            try {
                              await _auth.signOut();
                              Navigator.pushNamed(context, LoginScreen.id);
                            } catch (error) {
                              print(error);
                            }
                          },
                          icon: LineIcon(
                            LineIcons.alternateSignOut,
                            color: kBlack,
                          ),
                          label: Text(
                            "Logout",
                            style: kLoginHeading,
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
