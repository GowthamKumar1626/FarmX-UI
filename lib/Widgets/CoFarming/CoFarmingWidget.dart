import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Services/Models/UserModel.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import 'LocationDetails.dart';
import 'TimePickerScreen.dart';

class CoFarmingWidget extends StatefulWidget {
  const CoFarmingWidget({Key? key}) : super(key: key);

  @override
  _CoFarmingWidgetState createState() => _CoFarmingWidgetState();
}

class _CoFarmingWidgetState extends State<CoFarmingWidget> {
  final _key = GlobalKey<FormState>();

  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);
    bool isAnonymous = auth.currentUser!.isAnonymous;

    return StreamBuilder<UserModel>(
      stream: database.userDataStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data;
          print(userData!.isFarmer);

          return Column(
            children: [
              Form(
                key: _key,
                child: isAnonymous == true
                    ? isAnonymousForm()
                    : userData.isFarmer == true
                        ? coFarmingAvailabilityForm(context, userData)
                        : userCoFarmingForm(context),
              ),
            ],
          );
        }
        return Column(
          children: [
            Form(
              key: _key,
              child: Text("Anonymous"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUserNameText(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<List<UserModel>>(
      stream: database.getAllCoFarmingFarmers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data;
          final data = userData!
              .map(
                (user) => GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => LocationDetails(),
                      ),
                    );
                  },
                  child: Container(
                    child: LocationItem(
                      icon: Icons.location_pin,
                      text: "${user.name}-${user.locationName}",
                      locationText: "View Details",
                    ),
                  ),
                ),
              )
              .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: data,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No Farmers data",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  Column coFarmingAvailabilityForm(BuildContext context, UserModel userData) {
    final database = Provider.of<Database>(context, listen: false);
    return userData.coFarmingAvailable == "Not Selected"
        ? Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(6.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        "Are you available for Co-Farming?",
                        style: kDefaultStyle,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            child: Text('Yes'),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                (states) => kBlack,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isAvailable = true;
                                print(
                                    "Co-Farming availability status: $isAvailable");

                                UserModel model = UserModel(
                                  name: userData.name,
                                  phoneNumber: userData.phoneNumber,
                                  locationName: userData.locationName,
                                  locationDetails: userData.locationDetails,
                                  isFarmer: userData.isFarmer,
                                  coFarmingAvailable: isAvailable.toString(),
                                );

                                database.setGeneralUserData(model);
                              });
                            }),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            child: Text(
                              'No',
                              style: TextStyle(color: kBlack),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                (states) => kLightSecondaryColor,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                isAvailable = false;
                                print(
                                    "Co-Farming availability status: $isAvailable");

                                UserModel model = UserModel(
                                  name: userData.name,
                                  phoneNumber: userData.phoneNumber,
                                  locationName: userData.locationName,
                                  locationDetails: userData.locationDetails,
                                  isFarmer: userData.isFarmer,
                                  coFarmingAvailable: isAvailable.toString(),
                                );

                                database.setGeneralUserData(model);
                              });
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        : userData.coFarmingAvailable == "false"
            ? Column(
                children: [
                  Text("Not Eligible"),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("You are eligible for Co-Farming"),
                  Center(
                    child: TextButton(
                      child: Text(
                        "Edit your timings",
                        style: TextStyle(
                          color: kBlack,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => TimePickerScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
  }

  Column userCoFarmingForm(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            "Farmers available for Co-Farming:",
            style: kDefaultStyle,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        _buildUserNameText(context),
      ],
    );
  }

  Column isAnonymousForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Container(
            // padding: const EdgeInsets.all(16.0),
            width: MediaQuery.of(context).size.width * 0.8,
            child: new Column(
              children: <Widget>[
                new Text(
                  "Anonymous users are not available to access this feature.\n\nPlease create an account to use this feature",
                  textAlign: TextAlign.left,
                  style: kLabelStyleDefault,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LocationItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final String locationText;

  const LocationItem({
    required this.icon,
    required this.text,
    required this.locationText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 60,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kSpacingUnit * 2),
        color: kDarkSecondaryColor,
      ),
      child: Row(
        children: <Widget>[
          LineIcon(
            this.icon,
            color: Colors.white,
            size: kSpacingUnit * 2.5,
          ),
          SizedBox(width: kSpacingUnit * 1.5),
          Column(
            children: <Widget>[
              Text(
                this.text,
                style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  color: kLightSecondaryColor,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                this.locationText,
                style: kTitleTextStyle.copyWith(
                  fontWeight: FontWeight.w100,
                  fontSize: 15,
                  color: kLightSecondaryColor,
                ),
              ),
            ],
          ),
          Spacer(),
          LineIcon(
            LineIcons.angleRight,
            size: kSpacingUnit * 2.5,
            color: kAccentColor,
          ),
        ],
      ),
    );
  }
}
