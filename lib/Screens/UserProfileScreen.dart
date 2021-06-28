import 'dart:ui';

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Screens/ProfileEditScreens/CropInfoScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/GeneralInfoScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/HelpAndSupport.dart';
import 'package:farmx/Screens/ProfileEditScreens/PrivacySettingsScreen.dart';
import 'package:farmx/Screens/ProfileEditScreens/PurchaseHistory.dart';
import 'package:farmx/Screens/ProfileEditScreens/Widgets/ProfileListItem.dart';
import 'package:farmx/Services/Models/UserModel.dart';
import 'package:farmx/Services/auth.dart';
import 'package:farmx/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      backgroundColor: kDarkPrimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          color: Colors.white,
        ),
        backgroundColor: kDarkPrimaryColor,
        elevation: 0.0,
        title: Text(
          "Account",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                Positioned(
                  top: 50,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(45.0),
                        topRight: Radius.circular(45.0),
                      ),
                      color: Colors.white,
                    ),
                    height: MediaQuery.of(context).size.height * 2,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width * 0.1,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // border: Border.all(
                          //   width: 4,
                          //   color: Theme.of(context).scaffoldBackgroundColor,
                          // ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 10),
                              spreadRadius: 2,
                            ),
                          ],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/user.JPG"),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.1,
                  right: MediaQuery.of(context).size.width * 0.2,
                  child: Column(
                    children: <Widget>[
                      _buildUserNameText(context),
                      SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.25,
                  left: 25,
                  right: 25,
                  child: Column(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _buildSettingsList(context, auth),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserNameText(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<UserModel>(
      stream: database.userDataStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final userData = snapshot.data;
          return Text(
            userData!.name,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "HeyUser",
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto',
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildSettingsList(BuildContext context, AuthBase auth) {
    return [
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (BuildContext context) => Provider<Database>(
                create: (_) => FireStoreDatabase(uid: auth.currentUser!.uid),
                builder: (context, child) => GeneralInfoScreen(),
              ),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.infoCircle,
          text: "General Info",
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => CropInfoScreen(),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.tools,
          text: "Crop Info",
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => PrivacySettingsScreen(),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.userShield,
          text: "Privacy",
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => PurchaseHistory(),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.history,
          text: "Purchase History",
        ),
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute<void>(
              fullscreenDialog: true,
              builder: (context) => HelpAndSupport(),
            ),
          );
        },
        child: ProfileListItem(
          icon: LineIcons.questionCircle,
          text: "Help & Support",
        ),
      ),
    ];
  }
}

// BuildCropInfoCard
// class CropsCultivatedContainer extends StatelessWidget {
//   final int index;
//
//   CropsCultivatedContainer({
//     required this.index,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 100,
//       width: 70,
//       decoration: BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage(crops[index].imgPath),
//         ),
//       ),
//     );
//   }
// }

// Widget _buildUserNameText(BuildContext context) {
//   final database = Provider.of<Database>(context, listen: false);
//   return StreamBuilder<List<UserModel>>(
//     stream: database.getAllUsersDataStream(),
//     builder: (context, snapshot) {
//       if (snapshot.hasData) {
//         final userData = snapshot.data;
//         final data = userData!
//             .map((user) => Text(
//           user.name,
//           style: TextStyle(
//             color: Colors.black,
//             fontFamily: 'Roboto',
//             fontSize: 22.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ))
//             .toList();
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: data,
//         );
//       }
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "HeyUser",
//             style: TextStyle(
//               color: Colors.black,
//               fontFamily: 'Roboto',
//               fontSize: 22.0,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ],
//       );
//     },
//   );
// }
