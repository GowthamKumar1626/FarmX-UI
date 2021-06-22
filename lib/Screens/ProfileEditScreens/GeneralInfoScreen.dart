import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Constants/Errors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:geocoder/geocoder.dart';
import 'package:line_icons/line_icons.dart';
import 'package:location/location.dart';

enum states {
  SHOW_GENERAL_INFO,
  SHOW_GENERAL_INFO_EDIT_FORM,
}

class GeneralInfoScreen extends StatefulWidget {
  static const id = "general_info";

  @override
  _GeneralInfoScreenState createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
  final _key = GlobalKey<FormState>();
  var displayName, contactInfo, locationInfo, isFarmer;

  var displayNameInfo, displayContactInfo, displayLocationName;

  var displayState = states.SHOW_GENERAL_INFO;

  final _auth = FirebaseAuth.instance;

  Map<String, dynamic> locationCords = {
    "longitude": null,
    "latitude": null,
  };

  var uid;

  fetchData() async {
    DocumentSnapshot variable = await FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .get();

    setState(() {
      uid = _auth.currentUser!.uid;
      displayNameInfo = variable.data()!["displayName"];
      displayContactInfo = variable.data()!["contactInfo"];
      displayLocationName = variable.data()!["locationName"];
      isFarmer = variable.data()!["isFarmer"];
      print(isFarmer);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                displayState = states.SHOW_GENERAL_INFO_EDIT_FORM;
              });
            },
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: displayState == states.SHOW_GENERAL_INFO_EDIT_FORM
            ? generalInfoEdit(context)
            : generalInfo(context),
      ),
    );
  }

  Column generalInfo(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "General Info",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GeneralInfoFields(
                label: "Name",
                value: displayNameInfo.toString().contains('null')
                    ? "-"
                    : displayNameInfo.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              GeneralInfoFields(
                label: "Contact-Info",
                value: displayContactInfo.toString().contains('null')
                    ? '-'
                    : displayContactInfo.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              GeneralInfoFields(
                label: "Location",
                value: displayLocationName.toString().contains('null')
                    ? '-'
                    : displayLocationName.toString(),
              ),
              SizedBox(
                height: 10,
              ),
              GeneralInfoFields(
                label: "Farmer",
                value: isFarmer == null
                    ? '-'
                    : isFarmer == true
                        ? 'Yes'
                        : 'No',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column generalInfoEdit(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Edit General Info",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    GeneralInfoFormFields(
                      label: "Name",
                      icon: LineIcons.identificationBadge,
                      onChanged: (value) {
                        displayName = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GeneralInfoFormFields(
                      label: "Contact",
                      icon: LineIcons.alternatePhone,
                      onChanged: (value) {
                        displayContactInfo = value;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {
                            Future locationData() async {
                              dynamic _locationData = await locationGetter();
                              setState(
                                () async {
                                  locationCords["longitude"] =
                                      _locationData.longitude;
                                  locationCords["latitude"] =
                                      _locationData.latitude;

                                  final coordinates = new Coordinates(
                                    locationCords["latitude"],
                                    locationCords["longitude"],
                                  );
                                  var addresses = await Geocoder.local
                                      .findAddressesFromCoordinates(
                                          coordinates);
                                  var first = addresses.first;
                                  displayLocationName = first.locality;

                                  print("${first.locality}");
                                  // final query = "Sattenapalli";
                                  // var addresses = await Geocoder.local
                                  //     .findAddressesFromQuery(query);
                                  // var first = addresses.first;
                                  // print(
                                  //     "${first.featureName} : ${first.coordinates}");
                                },
                              );
                            }

                            locationData();
                          },
                          icon: Icon(
                            Icons.location_pin,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kBlack,
                            ),
                          ),
                          label: Text("Get Location"),
                        ),
                        Text(
                          displayLocationName.toString().contains('null')
                              ? '-'
                              : displayLocationName.toString(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kDarkPrimaryColor,
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            userGeneralInfo(
                              displayName,
                              displayContactInfo,
                              displayLocationName,
                              locationCords,
                              uid,
                            );
                            snackBar(context, "Changes updated.", 1);
                            Timer(Duration(seconds: 2), () {
                              // 5s over, navigate to a new page
                              setState(() {
                                fetchData();
                                displayState = states.SHOW_GENERAL_INFO;
                              });
                            });
                          },
                          child: Text(
                            "Save changes",
                            style: TextStyle(fontSize: 15),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kDarkPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GeneralInfoFormFields extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function(dynamic) onChanged;

  GeneralInfoFormFields({
    required this.label,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: kLabelStyleDefault,
        prefixIcon: Icon(
          icon,
          color: kBlack,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class GeneralInfoFields extends StatelessWidget {
  final String label;
  final String value;

  GeneralInfoFields({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          // padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.4,
          child: new Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        Container(
          // padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.4,
          child: new Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> userGeneralInfo(
  displayName,
  contactInfo,
  locationName,
  locationData,
  uid,
) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  final _auth = FirebaseAuth.instance;
  DocumentSnapshot existingDoc = await FirebaseFirestore.instance
      .collection('Users')
      .doc(_auth.currentUser!.uid)
      .get();

  Map<String, dynamic> userData = {
    'displayName': displayName,
    'contactInfo': contactInfo,
    'isFarmer': existingDoc.data()!["isFarmer"],
    "locationName": locationName,
    'locationData': locationData,
    'uid': uid,
  };

  dynamic userRef = users.doc(uid);

  try {
    await userRef.update(userData);
  } catch (error) {
    print(error);
  }
  return;
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
