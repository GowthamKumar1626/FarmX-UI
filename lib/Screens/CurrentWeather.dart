import 'dart:convert';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:farmx/Screens/Weather.dart';
import 'package:farmx/Screens/currentWeatherScreen.dart';
import 'package:farmx/Screens/weather/models/location.dart';
import 'package:farmx/Services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({Key? key}) : super(key: key);
  @override
  _CurrentWeatherPageState createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  List<Location> locations = [
    new Location(
        city: city1, country: "India", lat: "78.9629°", lon: "20.5937°")
  ];
  @override
  Widget build(BuildContext context) {
    // Weather? _weather;
    return SingleChildScrollView(
        child: Center(
            child: GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            fullscreenDialog: true,
            builder: (context) => CurrentWeatherScreenPage(locations, context),
          ),
        );
      },
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
        child: Container(
            padding: const EdgeInsets.all(5.0),
            margin: const EdgeInsets.all(5.0),
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3),
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Image(
                  image: AssetImage("assets/icons/weatherblack.png"),
                  width: 100,
                  height: 100,
                ),
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
            )),
      ),
    )));
  }
}

Widget weatherBox(Weather _weather) {
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
        Text(
            "${_weather.description[0].toUpperCase()}${_weather.description.substring(1)}"),
        SizedBox(
          height: 20,
        ),
        Text("Feels Like:${_weather.feelsLike}°C"),
        // style: TextStyle(
        //     fontWeight: FontWeight.normal,
        //     fontSize: 13,
        //     color: Colors.white))
        // Text("H:${_weather.high}°C   L:${_weather.low}°C"),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Column(
        //       children: [
        //         Container(
        //             child: Text(
        //           "Wind",
        //           textAlign: TextAlign.left,
        //           style: TextStyle(
        //               fontWeight: FontWeight.w600,
        //               fontSize: 12,
        //               color: Colors.black),
        //         )),
        //         Container(
        //             child: Text(
        //           "${_weather.wind} km/h",
        //           textAlign: TextAlign.left,
        //           style: TextStyle(
        //               fontWeight: FontWeight.w700,
        //               fontSize: 15,
        //               color: Colors.black),
        //         )),
        //       ],
        //     ),
        //     SizedBox(
        //       width: 5,
        //     ),
        //     Column(
        //       children: [
        //         Container(
        //             child: Text(
        //           "Humidity",
        //           textAlign: TextAlign.left,
        //           style: TextStyle(
        //               fontWeight: FontWeight.w600,
        //               fontSize: 12,
        //               color: Colors.black),
        //         )),
        //         Container(
        //             child: Text(
        //           "${_weather.humidity.toInt()}%",
        //           textAlign: TextAlign.left,
        //           style: TextStyle(
        //               fontWeight: FontWeight.w700,
        //               fontSize: 15,
        //               color: Colors.black),
        //         ))
        //       ],
        //     ),
        //     SizedBox(
        //       width: 5,
        //     ),
        //     Column(
        //       children: [
        //         Container(
        //             child: Text(
        //           "Pressure",
        //           textAlign: TextAlign.left,
        //           style: TextStyle(
        //               fontWeight: FontWeight.w600,
        //               fontSize: 12,
        //               color: Colors.black),
        //         )),
        //         Container(
        //             child: Text(
        //           "${_weather.pressure} hPa",
        //           textAlign: TextAlign.left,
        //           style: TextStyle(
        //               fontWeight: FontWeight.w700,
        //               fontSize: 15,
        //               color: Colors.black),
        //         ))
        //       ],
        //     )
        //   ],
        // )
      ],
    ),
  );
}

String city1 = "Vijayawada";
Future getCurrentWeather(BuildContext context) async {
  final location = Provider.of<LocationService>(context, listen: false);
  Weather? weather;
  String city = await location.locationName();
  city1 = city;
  String apiKey = "7e8d6cea22d980cbea8835e0f093ab28";
  var url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric");

  final response = await http.get(url);
  if (response.statusCode == 200) {
    weather = Weather.fromJson(jsonDecode(response.body));
  } else {}

  return weather;
}

Widget generateBlurredImage() {
  return new Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        image: new AssetImage('assets/images/huxley-lsd.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: new BackdropFilter(
      filter: new ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
      child: new Container(
        //you can change opacity with color here(I used black) for background.
        decoration: new BoxDecoration(color: Colors.black.withOpacity(0.2)),
      ),
    ),
  );
}
