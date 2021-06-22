import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmx/Constants/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class CoFarmingWidget extends StatefulWidget {
  const CoFarmingWidget({Key? key}) : super(key: key);

  @override
  _CoFarmingWidgetState createState() => _CoFarmingWidgetState();
}

class _CoFarmingWidgetState extends State<CoFarmingWidget> {
  final _key = GlobalKey<FormState>();

  final _auth = auth.FirebaseAuth.instance;
  var isFarmer, uid;
  bool isAvailable = false;
  bool isAnonymous = false;

  double _currentSliderValue = 10;

  @override
  void initState() {
    Firebase.initializeApp();
    uid = _auth.currentUser!.uid;
    fetchUserDetails(uid);
    isAnonymous = _auth.currentUser!.isAnonymous;
    super.initState();
  }

  fetchUserDetails(uid) async {
    DocumentSnapshot variable =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    setState(() {
      isFarmer = variable.data()!["isFarmer"];
      print("IS farmer: $isFarmer");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: isAnonymous == true
          ? isAnonymousForm()
          : isFarmer == true
              ? coFarmingAvailabilityForm()
              : userCoFarmingForm(),
    );
  }

  Column coFarmingAvailabilityForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            "Are you available for Co-Farming?",
            style: kDefaultStyle,
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
                      print("Co-Farming availability status: $isAvailable");
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
                      print("Co-Farming availability status: $isAvailable");
                    });
                  }),
            ),
          ],
        ),
      ],
    );
  }

  Column userCoFarmingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            "Select the radius (in KM)",
            style: kDefaultStyle,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Slider(
              value: _currentSliderValue,
              min: 0,
              max: 50,
              divisions: 5,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
              activeColor: kBlack,
              inactiveColor: kLightSecondaryColor,
            ),
            ElevatedButton.icon(
              label: Text("Search"),
              icon: Icon(
                Icons.search,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => kBlack,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.all(6.0),
          child: Text(
            "Selected radius: $_currentSliderValue",
            style: kToolNameStyleBlack,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                child: LocationItem(
                  icon: Icons.location_pin,
                  text: "Kurapadu",
                  locationText: "6 KM from here",
                ),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                child: LocationItem(
                  icon: Icons.location_pin,
                  text: "Kurapadu",
                  locationText: "6 KM from here",
                ),
              ),
            ),
          ],
        ),
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
