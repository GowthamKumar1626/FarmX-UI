import 'package:farmx/Screens/LandingScreen.dart';
import 'package:farmx/Services/location.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Services/auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => Auth(),
      child: Provider<LocationService>(
        create: (context) => LocationCoordinates(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "FarmX",
          theme: ThemeData(
            primarySwatch: Colors.indigo,
          ),
          home: LandingScreen(),
        ),
      ),
    );
  }
}
