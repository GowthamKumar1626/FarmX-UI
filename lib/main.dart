import 'package:farmx/Screens/HomeScreen.dart';
import 'package:farmx/Screens/LoginScreen.dart';
import 'package:farmx/Screens/ToolScreen.dart';
import 'package:farmx/Screens/UserProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/RegistrationScreen.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'LeonSans',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: HomeScreen.id,
          routes: {
            RegistrationScreen.id: (context) => RegistrationScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            ToolScreen.id: (context) => ToolScreen(),
            UserProfileScreen.id: (context) => UserProfileScreen(),
          },
        );
      },
    );
  }
}
