import 'dart:ui';

import 'package:farmx/Screens/LoginScreen.dart';
import 'package:farmx/Widgets/CropSuggestion/CropSuggestionWidget.dart';
import 'package:farmx/Widgets/FertilizerSuggestion/FertilizerSuggestionWidget.dart';
import 'package:farmx/Widgets/GeneralCropInfo/GeneralCropInfoWidget.dart';
import 'package:farmx/Widgets/PestDetection/PestDetectionWidget.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../Constants/Constants.dart';
import '../Constants/Tools.dart';

class ToolScreen extends StatefulWidget {
  static const id = "tool_screen";

  @override
  _ToolScreenState createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  String title = "Pest Detection";
  int currentIndex = 0; //Walk through features

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final _auth = auth.FirebaseAuth.instance;

  Widget toolWidget = PestDetectionWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 25,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          customBorder: CircleBorder(),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.search,
                              size: 30,
                            ),
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () async {
                            try {
                              await _auth.signOut();
                              Navigator.pushNamed(context, LoginScreen.id);
                            } catch (error) {
                              print(error);
                            }
                          },
                          child: Text(
                            "Logout",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      "Hey User",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 17,
                        color: kGrey,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tools provided',
                      style: kGreetingsStyle,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 70.0,
                            child: new ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: toolIcons.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ToolContainer(
                                  index: index,
                                  getCurrentIndex: () => currentIndex,
                                  setCurrentIndex: () {
                                    setState(
                                      () {
                                        currentIndex = index;
                                        title = toolIcons[index].name;
                                        switch (title) {
                                          case "Pest Detection":
                                            toolWidget = PestDetectionWidget();
                                            break;
                                          case "Fertilizer":
                                            toolWidget =
                                                FertilizerSuggestionWidget();
                                            break;
                                          case "Crop Suggestion":
                                            toolWidget = CropSuggestionWidget();
                                            break;
                                          case "General Crop-Info":
                                            toolWidget =
                                                GeneralCropInfoWidget();
                                            break;
                                          default:
                                            toolWidget = Container(
                                              child: Text(
                                                "Tool will be implemented Soon!",
                                                style: kDefaultStyle,
                                              ),
                                            );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  width: 5,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: kToolSelected,
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              child: toolWidget,
                            ),
                          ],
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
    );
  }
}

class ToolContainer extends StatelessWidget {
  final int index;
  final VoidCallback? setCurrentIndex;
  final Function() getCurrentIndex;

  ToolContainer({
    required this.index,
    required this.getCurrentIndex,
    this.setCurrentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return CategoryButton(
      image: AssetImage(toolIcons[index].imgPath),
      color: toolIcons[index].color,
      onPressed: () => setCurrentIndex!(),
      isSelected: getCurrentIndex() == index,
    );
  }
}

class CategoryButton extends StatelessWidget {
  final AssetImage image;
  final Color color;
  final Function() onPressed;
  final bool isSelected;

  CategoryButton({
    required this.image,
    required this.color,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      fillColor: isSelected ? color.withAlpha(100) : kLightGrey,
      constraints: BoxConstraints.tightFor(
        width: 70,
        height: 75,
      ),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: image,
      ),
      // child: Icon(
      //   icon,
      //   size: 30,
      //   color: color,
      // ),
    );
  }
}
