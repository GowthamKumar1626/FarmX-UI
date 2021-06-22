import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationDetails extends StatefulWidget {
  static const id = "location_details";

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  late GoogleMapController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkPrimaryColor,
        title: Text(
          "Map",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(16.3988129, 80.1482662),
            zoom: 12.0,
          ),
          zoomControlsEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
        ),
      ),
    );
  }
}
