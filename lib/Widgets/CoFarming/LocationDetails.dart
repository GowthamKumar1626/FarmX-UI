import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Services/Models/UserModel.dart';
import 'package:farmx/Services/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class LocationDetails extends StatefulWidget {
  LocationDetails({required this.farmer, required this.currentUser});
  final UserModel farmer;
  final UserModel currentUser;
  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
  Set<Marker> _markers = {};
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId("Farmer"),
          position: LatLng(
            widget.farmer.locationDetails["latitude"],
            widget.farmer.locationDetails["longitude"],
          ),
          infoWindow: InfoWindow(
            title: "Farmer Location",
            snippet: "Destination",
          ),
        ),
      );
      _markers.add(
        Marker(
          markerId: MarkerId("User"),
          position: LatLng(
            widget.currentUser.locationDetails["latitude"],
            widget.currentUser.locationDetails["longitude"],
          ),
          infoWindow: InfoWindow(
            title: "${widget.currentUser.name}-Location",
            snippet: "Start",
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final location = Provider.of<LocationService>(context, listen: false);

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: GoogleMap(
                markers: _markers,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    // widget.currentUser.locationDetails["latitude"],
                    // widget.currentUser.locationDetails["longitude"],
                    widget.farmer.locationDetails["latitude"],
                    widget.farmer.locationDetails["longitude"],
                  ),
                  zoom: 12.0,
                ),
                zoomControlsEnabled: true,
                onMapCreated: _onMapCreated,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Farmer Details",
              style: kTopHeadingStyle,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Name:",
                  style: kDefaultStyle,
                ),
                Text(
                  widget.farmer.name,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Location:",
                  style: kDefaultStyle,
                ),
                Text(
                  widget.farmer.locationName,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Time available:",
                  style: kDefaultStyle,
                ),
                Text(
                  widget.farmer.selectedDate,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Exit"),
            ),
          ],
        ),
      ),
    );
  }
}
