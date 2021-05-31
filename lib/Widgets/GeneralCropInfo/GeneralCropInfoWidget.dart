import 'dart:convert';

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Widgets/GeneralCropInfo/ListOfConditions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<dynamic, dynamic>> predictCropInfo(var body) async {
  var uri =
      Uri.parse("https://farmx-crop-recommendation.herokuapp.com/cropsuggest");
  Map<String, String> headers = {"Content-type": "application/json"};
  String jsonString = json.encode(body);

  try {
    var resp = await http.post(uri, headers: headers, body: jsonString);
    if (resp.statusCode == 200) {
      print("DATA FETCHED SUCCESSFULLY");
      Map<dynamic, dynamic> result = json.decode(resp.body);

      final Map<dynamic, dynamic> data =
          result.map((key, value) => MapEntry(key.toString(), value));

      return data;
    } else if (resp.statusCode == 405) {
      print("405 status code");
    } else {
      print("failed");
    }
  } catch (e) {
    print("EXCEPTION OCCURRED: $e");
    return Future.error("Exception Occurred");
  }
  return Future.error("Exception occurred");
}

class GeneralCropInfoWidget extends StatefulWidget {
  static const id = "general_crop_info";
  @override
  _GeneralCropInfoWidgetState createState() => _GeneralCropInfoWidgetState();
}

class _GeneralCropInfoWidgetState extends State<GeneralCropInfoWidget> {
  final _key = GlobalKey<FormState>();

  final List<String> states = [
    "Andhra Pradesh",
    "Arunachal Pradesh ",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jammu and Kashmir",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
    "Andaman and Nicobar Islands",
    "Chandigarh",
    "Dadra and Nagar Haveli",
    "Daman and Diu",
    "Lakshadweep",
    "National Capital Territory of Delhi",
    "Puducherry"
  ];

  var selectedState;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(6.0),
            child: Text(
              "Select your state:",
              style: kDefaultStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 16),
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DropdownButton(
                hint: Text('Select a state'),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                value: selectedState,
                onChanged: (value) {
                  setState(() {
                    selectedState = value;
                  });
                },
                items: states.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              child: Text('Submit'),
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                  (states) => kPrimaryGreen,
                ),
              ),
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  print('success');
                }
                var body = [
                  {
                    'State': selectedState,
                  }
                ];

                Map<dynamic, dynamic> resp = await predictCropInfo(body);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CropInfo(resp);
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class CropInfo extends StatelessWidget {
  var info;

  List? keys, values;
  CropInfo(Map<dynamic, dynamic> resp) {
    info = resp;
    keys = info['suggestion'].keys.toList();
    values = info['suggestion'].values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Crop Suggestions'),
        centerTitle: true,
        backgroundColor: Colors.green[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Container(
            child: Center(
              child: ListView(
                children: [
                  Text(
                    'These are the suggested crop varieties in your selected region.',
                  ),
                  SizedBox(height: 10),
                  DataTable(
                    dataRowHeight: 60,
                    columns: [
                      DataColumn(label: Text('Crop')),
                      DataColumn(label: Text('Variety')),
                    ],
                    rows: List.generate(
                        keys!.length,
                        (index) => DataRow(cells: [
                              DataCell(Text(keys![index])),
                              DataCell(Text(values![index])),
                            ])),
                  ),
                  SizedBox(height: 10),
                  // Text(),
                  SizedBox(height: 10),
                  TextButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                          (states) => kPrimaryGreen,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TableView();
                            },
                          ),
                        );
                      },
                      child: new Text('View Conditions'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
