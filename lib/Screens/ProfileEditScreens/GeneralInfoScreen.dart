import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Services/Models/UserModel.dart';
import 'package:farmx/Services/database.dart';
import 'package:farmx/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

enum states {
  SHOW_GENERAL_INFO,
  SHOW_GENERAL_INFO_EDIT_FORM,
}

class GeneralInfoScreen extends StatefulWidget {
  @override
  _GeneralInfoScreenState createState() => _GeneralInfoScreenState();
}

class _GeneralInfoScreenState extends State<GeneralInfoScreen> {
  states displayState = states.SHOW_GENERAL_INFO;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kDarkPrimaryColor,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: displayState == states.SHOW_GENERAL_INFO_EDIT_FORM
            ? generalInfoEdit(context)
            : generalInfo(context),
      ),
    );
  }

  Widget generalInfo(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    return StreamBuilder<UserModel>(
        stream: database.userDataStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data;
            return Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "General Info",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      GeneralInfoFields(
                        label: "Name",
                        value: userData!.name,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GeneralInfoFields(
                        label: "Contact-Info",
                        value: userData.phoneNumber == ""
                            ? "-"
                            : userData.phoneNumber,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GeneralInfoFields(
                        label: "Location",
                        value: userData.locationName == ""
                            ? "-"
                            : userData.locationName,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GeneralInfoFields(
                        label: "Farmer",
                        value: userData.isFarmer.toString() == "false"
                            ? "No"
                            : "Yes",
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            displayState = states.SHOW_GENERAL_INFO_EDIT_FORM;
                          });
                        },
                        child: Text(
                          "Edit",
                          style: kDefaultStyle,
                        ),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  S.load(Locale("te"));
                                });
                              },
                              child: Text("తెలుగుకు మార్చండి")),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  S.load(Locale("hi"));
                                });
                              },
                              child: Text("हिंदी में बदलें")),
                          ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  S.load(Locale("en"));
                                });
                              },
                              child: Text("Change to English")),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          }
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "General Info",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GeneralInfoFields(
                      label: "Name",
                      value: "-",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GeneralInfoFields(
                      label: "Contact-Info",
                      value: "-",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GeneralInfoFields(
                      label: "Location",
                      value: "-",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GeneralInfoFields(
                      label: "Farmer",
                      value: "-",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          displayState = states.SHOW_GENERAL_INFO_EDIT_FORM;
                        });
                      },
                      child: Text(
                        "Edit",
                        style: kDefaultStyle,
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                //Locale myLocale = Localizations.localeOf(context);
                                S.load(Locale("te"));
                              });
                            },
                            child: Text("తెలుగుకు మార్చండి")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                S.load(Locale("hi"));
                              });
                            },
                            child: Text("हिंदी में बदलें")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                S.load(Locale("en"));
                              });
                            },
                            child: Text("Change to English")),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  Column generalInfoEdit(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Edit General Info",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _key,
                child: Column(
                  children: <Widget>[
                    GeneralInfoFormFields(
                      label: "Name",
                      icon: LineIcons.identificationBadge,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GeneralInfoFormFields(
                      label: "Contact",
                      icon: LineIcons.alternatePhone,
                      onChanged: (value) {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Icons.location_pin,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kBlack,
                            ),
                          ),
                          label: Text("Get Location"),
                        ),
                        Text(
                          "-",
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kDarkPrimaryColor,
                            ),
                          ),
                          child: Text(
                            "Cancel",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {},
                          child: Text(
                            "Save changes",
                            style: TextStyle(fontSize: 15),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                              (states) => kDarkPrimaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GeneralInfoFormFields extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function(dynamic) onChanged;

  GeneralInfoFormFields({
    required this.label,
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.name,
      cursorColor: Colors.black,
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        labelStyle: kLabelStyleDefault,
        prefixIcon: Icon(
          icon,
          color: kBlack,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

class GeneralInfoFields extends StatelessWidget {
  final String label;
  final String value;

  GeneralInfoFields({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          // padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.4,
          child: new Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        Container(
          // padding: const EdgeInsets.all(16.0),
          width: MediaQuery.of(context).size.width * 0.4,
          child: new Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// void userData() async {
//   await database.setGeneralUserData(
//       UserModel(name: "test@email.com", isFarmer: true));
// }
//
// userData();
