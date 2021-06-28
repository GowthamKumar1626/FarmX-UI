import 'dart:ui';

import 'package:farmx/Screens/CurrentWeather.dart';
import 'package:farmx/Screens/UserProfileScreen.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Services/database.dart';
import 'package:farmx/Widgets/CoFarming/CoFarmingWidget.dart';
import 'package:farmx/Widgets/CropSuggestion/CropSuggestionWidget.dart';
import 'package:farmx/Widgets/FertilizerSuggestion/FertilizerSuggestionWidget.dart';
import 'package:farmx/Widgets/GeneralCropInfo/GeneralCropInfoWidget.dart';
import 'package:farmx/Widgets/PestDetection/PestDetectionWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Constants/Constants.dart';
import '../Constants/Tools.dart';

class ToolScreen extends StatefulWidget {
  @override
  _ToolScreenState createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  String title = "Pest Detection";
  int currentIndex = 0; //Walk through features
  Widget toolWidget = PestDetectionWidget();

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

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
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => Provider<Database>(
                    create: (_) =>
                        FireStoreDatabase(uid: auth.currentUser!.uid),
                    builder: (context, child) => UserProfileScreen(),
                  ),
                ),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.only(
                right: 10,
                top: 10,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 10),
                    spreadRadius: 2,
                  ),
                ],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/user.JPG"),
                ),
              ),
            ),
          ),
        ],
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
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     Expanded(
                    //       child: SizedBox(
                    //         height: 80.0,
                    //         child: ListView(
                    //           // This next line does the trick.
                    //           scrollDirection: Axis.horizontal,
                    //           children: <Widget>[
                    //             Container(
                    //               width: 160.0,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 color: Colors.grey.withOpacity(0.2),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 10,
                    //             ),
                    //             Container(
                    //               width: 160.0,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 color: Colors.grey.withOpacity(0.2),
                    //               ),
                    //             ),
                    //             SizedBox(
                    //               width: 10,
                    //             ),
                    //             Container(
                    //               width: 160.0,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 color: Colors.grey.withOpacity(0.8),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    CurrentWeatherPage(),
                    Text(
                      '$title',
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
                                          case "Co-Farming":
                                            toolWidget = CoFarmingWidget();
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
        height: 85,
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
