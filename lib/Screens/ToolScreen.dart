import 'dart:ui';

import 'package:farmx/Screens/UserProfileScreen.dart';
import 'package:farmx/Widgets/PestDetectionWidget.dart';
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
  int currentIndex = 0;

  Widget toolWidget = PestDetectionWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
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
                        onPressed: () {
                          Navigator.pushNamed(context, UserProfileScreen.id);
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.transparent,
                          backgroundImage: AssetImage("assets/icons/man.png"),
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
                  toolWidget,
                ],
              ),
            ),
            Spacer(),
          ],
        ),
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
