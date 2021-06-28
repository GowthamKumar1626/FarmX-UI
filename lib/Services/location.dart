import 'package:farmx/Services/Models/LocationModel.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart';

abstract class LocationService {
  Future<LocationData> locationGetter();
  Future<Coordinates> locationData();
}

class LocationCoordinates implements LocationService {
  Future<LocationData> locationGetter() async {
    Location location = new Location();

    bool _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return Future.error('Location service not enabled');
      }
    }

    PermissionStatus _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return Future.error('Location permissions are denied');
      }
    }

    return await location.getLocation();
  }

  Future<Coordinates> locationData() async {
    dynamic _locationData = await locationGetter();
    LocationModel model = LocationModel();
    model.updateWith(
      latitude: _locationData.latitude,
      longitude: _locationData.longitude,
    );
    Coordinates cords = model.getCoordinates();
    return cords;
  }
}
