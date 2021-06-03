import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class CropInfoScreen extends StatefulWidget {
  static const id = "crop_info";

  @override
  _CropInfoScreenState createState() => _CropInfoScreenState();
}

class _CropInfoScreenState extends State<CropInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, HomeScreen.id);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
        ),
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
