import 'package:farmx/Screens/HomeScreen.dart';
import 'package:farmx/Screens/LoginScreen.dart';
import 'package:farmx/Screens/NewsFeedScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/CropInfoScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/GeneralInfoScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/PrivacySettingsScreen.dart';
import 'package:farmx/Screens/ToolScreen.dart';
import 'package:farmx/Screens/UserProfileScreen.dart';
import 'package:farmx/Widgets/CoFarming/LocationDetails.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screens/RegistrationScreen.dart';
import 'package:farmx/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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
          onGenerateTitle: (BuildContext context) => S.of(context).appTitle,
          theme: ThemeData(
            fontFamily: 'LeonSans',
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          localizationsDelegates: [
            S.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ],
          supportedLocales: S.delegate.supportedLocales,
          initialRoute: LoginScreen.id,
          routes: {
            RegistrationScreen.id: (context) => RegistrationScreen(),
            LoginScreen.id: (context) => LoginScreen(),
            HomeScreen.id: (context) => HomeScreen(),
            ToolScreen.id: (context) => ToolScreen(),
            NewsFeedScreen.id: (context) => NewsFeedScreen(),
            UserProfileScreen.id: (context) => UserProfileScreen(),
            GeneralInfoScreen.id: (context) => GeneralInfoScreen(),
            PrivacySettingsScreen.id: (context) => PrivacySettingsScreen(),
            CropInfoScreen.id: (context) => CropInfoScreen(),
            LocationDetails.id: (context) => LocationDetails(),
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
