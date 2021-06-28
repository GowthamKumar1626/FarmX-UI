import 'package:flutter/foundation.dart';
import 'package:geocoder/geocoder.dart';

class LocationModel with ChangeNotifier {
  LocationModel({
    this.latitude = 0.0,
    this.longitude = 0.0,
  });

  double latitude;
  double longitude;

  void updateLatitude(double latitude) => updateWith(latitude: latitude);
  void updateLongitude(double longitude) => updateWith(longitude: longitude);

  void updateWith({
    var latitude,
    var longitude,
  }) {
    this.latitude = latitude ?? this.latitude;
    this.longitude = longitude ?? this.longitude;
    notifyListeners();
  }

  Coordinates getCoordinates() {
    return Coordinates(
      this.latitude,
      this.longitude,
    );
  }
}
