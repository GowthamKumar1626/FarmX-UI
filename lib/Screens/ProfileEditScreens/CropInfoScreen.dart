import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

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
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Crop Details",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        // padding: const EdgeInsets.all(16.0),
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: new Column(
                          children: <Widget>[
                            new Text(
                                "Add the crops that you have grow before in your field",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.left),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          LineIcons.plusSquare,
                          size: 40,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
