import 'package:farmx/Screens/HomeScreen.dart';
import 'package:farmx/Screens/LoginScreen.dart';
import 'package:farmx/Screens/ProfileEditingScreen.dart';
import 'package:farmx/Screens/ToolScreen.dart';
import 'package:farmx/Screens/UserProfileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/RegistrationScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'LeonSans',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: LoginScreen.id,
          routes: {
            RegistrationScreen.id: (context) => RegistrationScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            ToolScreen.id: (context) => ToolScreen(),
            UserProfileScreen.id: (context) => UserProfileScreen(),
            ProfileEditingScreen.id: (context) => ProfileEditingScreen(),
          },
        );
        //   if (snapshot.hasError) {
        //     return MaterialApp(
        //       home: Scaffold(
        //         body: Center(
        //           child: Text("Error: ${snapshot.error}"),
        //         ),
        //       ),
        //     );
        //   }
        //
        //   if (snapshot.connectionState == ConnectionState.done) {
        //     return MaterialApp(
        //       debugShowCheckedModeBanner: false,
        //       theme: ThemeData(
        //         fontFamily: 'LeonSans',
        //         visualDensity: VisualDensity.adaptivePlatformDensity,
        //       ),
        //       initialRoute: LoginScreen.id,
        //       routes: {
        //         RegistrationScreen.id: (context) => RegistrationScreen(),
        //         LoginScreen.id: (context) => LoginScreen(),
        //         HomeScreen.id: (context) => HomeScreen(),
        //         ToolScreen.id: (context) => ToolScreen(),
        //         UserProfileScreen.id: (context) => UserProfileScreen(),
        //       },
        //     );
        //   }
        //   return MaterialApp(
        //     home: Scaffold(
        //       body: Center(
        //         child: Text("Connecting to app.."),
        //       ),
        //     ),
        //   );
      },
    );
  }
}
