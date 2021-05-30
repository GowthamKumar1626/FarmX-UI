import 'dart:ui';

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Constants/Crops.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class UserProfileScreen extends StatefulWidget {
  static const id = "user_profile";
  final heroTag = "HeroTag";

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  var selectedCrop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUserProfileBackGround,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 82.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.transparent,
              ),
              Positioned(
                top: 50,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                    color: Colors.white,
                  ),
                  height: MediaQuery.of(context).size.height - 100.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              Positioned(
                top: 25,
                left: (MediaQuery.of(context).size.width / 2) - 100.0,
                child: Hero(
                  tag: widget.heroTag,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/icons/man.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 200,
                    width: 200,
                  ),
                ),
              ),
              Positioned(
                top: 250,
                left: 25,
                right: 25,
                child: Column(
                  children: <Widget>[
                    Text(
                      "Hey User!",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Contact info: ",
                                style: kProfileHeadersStyle,
                              ),
                            ),
                            Container(
                              child: Text(
                                "+91 9705908495",
                                style: kProfileContent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Occupation:",
                                style: kProfileHeadersStyle,
                              ),
                            ),
                            Container(
                              child: Text(
                                "Farmer",
                                style: kProfileContent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Location:",
                                style: kProfileHeadersStyle,
                              ),
                            ),
                            Column(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Sattenapalli, Guntur",
                                    style: kProfileContent,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "Lat: 23.05" + ", Lon: -192",
                                    style: kProfileContent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Nationality:",
                                style: kProfileHeadersStyle,
                              ),
                            ),
                            Container(
                              child: Text(
                                "India",
                                style: kProfileContent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Field Details",
                                style: kTopHeadingStyle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    "Amount of Land",
                                    style: kProfileHeadersStyle,
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    "in Acres",
                                    style: kProfileHeadersStyle,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              child: Text(
                                "2",
                                style: kProfileContent,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Soil type:",
                                style: kProfileHeadersStyle,
                              ),
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: kBrownSoil,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Text(
                                "Crop Details",
                                style: kTopHeadingStyle,
                              ),
                            ),
                          ],
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
                                  itemCount: crops.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CropsCultivatedContainer(
                                      index: index,
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 10,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

// BuildCropInfoCard
class CropsCultivatedContainer extends StatelessWidget {
  final int index;

  CropsCultivatedContainer({
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 70,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(crops[index].imgPath),
        ),
      ),
    );
  }
}

//Location Getter

Future<LocationData> locationGetter() async {
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return Future.error('Location service not enabled');
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return Future.error('Location permissions are denied');
    }
  }

  _locationData = await location.getLocation();
  return _locationData;
}
