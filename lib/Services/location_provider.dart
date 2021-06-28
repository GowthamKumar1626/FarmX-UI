import 'package:farmx/Services/location.dart';
import 'package:flutter/cupertino.dart';

class LocationProvider extends InheritedWidget {
  LocationProvider({required this.location, required this.child})
      : super(child: child);
  final LocationService location;
  final Widget child;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static LocationService of(BuildContext context) {
    LocationProvider? provider =
        context.dependOnInheritedWidgetOfExactType<LocationProvider>();
    return provider!.location;
  }
}
