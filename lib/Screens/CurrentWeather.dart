import 'dart:convert';

import 'package:farmx/Screens/Weather.dart';
import 'package:farmx/Services/location.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);

  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Center(
      child: Container(
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(Icons.cloud),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    Weather? _weather = snapshot.data as Weather?;
                    if (_weather == null) {
                      return Text("error getting weather data");
                    } else {
                      return weatherBox(_weather);
                    }
                  } else {
                    return Text("oops!!");
                  }
                },
                future: getCurrentWeather(context),
              ),
            ],
          )
          // child: FutureBuilder(
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       Weather? _weather = snapshot.data as Weather?;
          //       if (_weather == null) {
          //         return Text("error getting weather data");
          //       } else {
          //         return weatherBox(_weather);
          //       }
          //     } else {
          //       return Text("oops!!");
          //     }
          //   },
          //   future: getCurrentWeather(),
          // ),
          ),
    ));
  }
}

Widget weatherBox(Weather _weather) {
  // return Column(
  //   children: [
  //     Container(
  //         margin: const EdgeInsets.all(10),
  //         child: Text(
  //           "${_weather.temp}°C",
  //           textAlign: TextAlign.center,
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
  //         )),
  //     Text("${_weather.description}"),
  //     Text("Feels:${_weather.feelsLike}°C"),
  //     Text("H:${_weather.high}°C L:${_weather.low}°C"),
  //   ],
  // );
  return SingleChildScrollView(
      child: Column(
    children: <Widget>[
      Container(
          margin: const EdgeInsets.all(10),
          child: Text(
            "${_weather.temp}°C",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
          )),
      Text("${_weather.description}"),
      Text("Feels:${_weather.feelsLike}°C"),
      Text("H:${_weather.high}°C L:${_weather.low}°C"),
    ],
  ));
}

Future getCurrentWeather(BuildContext context) async {
  final location = Provider.of<LocationService>(context, listen: false);
  Weather? weather;

  Coordinates coordinates = await location.locationData();
  var addresses =
      await Geocoder.local.findAddressesFromCoordinates(coordinates);

  String city = addresses.first.locality;
  print(city);
  String apiKey = "7e8d6cea22d980cbea8835e0f093ab28";
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

  final response = await http.get(url);
  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {}

  return weather;
}
