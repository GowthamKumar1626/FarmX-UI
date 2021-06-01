import 'dart:convert';

import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FertilizerSuggestionWidget extends StatefulWidget {
  @override
  _FertilizerSuggestionWidgetState createState() =>
      _FertilizerSuggestionWidgetState();
}

class _FertilizerSuggestionWidgetState
    extends State<FertilizerSuggestionWidget> {
  final _key = GlobalKey<FormState>();

  final List<String> typeOfSoils = ['Sandy', 'Loamy', 'Black', 'Red', 'Clayey'];
  final List<String> typeOfCrops = [
    'Maize',
    'Sugarcane',
    'Cotton',
    'Tobacco',
    'Paddy',
    'Barley',
    'Wheat',
    'Millets',
    'Oil seeds',
    'Pulses',
    'Ground Nuts'
  ];

  double? n, p, k, temperature, humidity, moisture;
  var selectedSoilType;
  var selectedCropType;

  var encodedCropType = {
    'Barley': 5,
    'Cotton': 2,
    'Ground Nuts': 10,
    'Maize': 0,
    'Millets': 7,
    'Oil seeds': 8,
    'Paddy': 4,
    'Pulses': 9,
    'Sugarcane': 1,
    'Tobacco': 3,
    'Wheat': 6
  };

  var encodedSoilType = {
    "Sandy": 1,
    "Loamy": 2,
    "Black": 3,
    "Red": 4,
    "Clayey": 5
  };

  Future<Map<String, dynamic>> predictFertiliser(var body) async {
    var uri =
        Uri.parse("https://farmx-crop-recommendation.herokuapp.com/fertrec");
    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonString = json.encode(body);
    try {
      var response = await http.post(uri, headers: headers, body: jsonString);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY");
        var result = json.decode(response.body);
        print(result);
        print(result['prediction']);

        var resultDict = {
          'prediction': result['prediction'],
          'statusCode': response.statusCode,
        };

        return resultDict;
      } else if (response.statusCode == 405) {
        print("405 status code");
      } else {
        print("failed");
      }
    } catch (e) {
      print("EXCEPTION OCCURRED: $e");
      return Future.error("Exception Occurred");
    }
    return Future.error("Exception Occurred");
  }

  Map<String, dynamic> resultDict = {
    'prediction': "Exception Occurred",
    'statusCode': 405,
  };

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Add TextFormFields and ElevatedButton here.
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'It cannot be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Nitrogen',
                  hintText: 'Enter a value',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  n = double.parse(value);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'It cannot be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Phosphate',
                    hintText: 'Enter a value',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (value) {
                  p = double.parse(value);
                },
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'It cannot be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Potassium(k)',
                  hintText: 'Enter a value',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  k = double.parse(value);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'It cannot be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Temperature',
                  hintText: 'Enter a value',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  temperature = double.parse(value);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'It cannot be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Humidity',
                  hintText: 'Enter a value',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  humidity = double.parse(value);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null) {
                    return 'It cannot be empty';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Moisture',
                  hintText: 'Enter a value',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  moisture = double.parse(value);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DropdownButton(
                hint: Text('Select a SoilType'),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                value: selectedSoilType,
                onChanged: (value) {
                  setState(() {
                    selectedSoilType = value;
                  });
                },
                items: typeOfSoils.map((valueItem) {
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
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 1),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: DropdownButton(
                hint: Text('Select a CropType'),
                icon: Icon(Icons.arrow_drop_down),
                iconSize: 36,
                isExpanded: true,
                underline: SizedBox(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                value: selectedCropType,
                onChanged: (value) {
                  setState(() {
                    selectedCropType = value;
                  });
                },
                items: typeOfCrops.map((valueItem) {
                  return DropdownMenuItem(
                    value: valueItem,
                    child: Text(valueItem),
                  );
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              child: Text('Submit'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kYellow),
              ),
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  print('success');
                }
                var body = [
                  {
                    'N': n,
                    'P': p,
                    'K': k,
                    'temperature': temperature,
                    'humidity': humidity,
                    'moisture': moisture,
                    'Soil Type': encodedSoilType[selectedSoilType],
                    'Crop Type': encodedCropType[selectedCropType],
                  }
                ];
                print(body);
                var response = await predictFertiliser(body);
                setState(() {
                  resultDict = response;
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(
                        "${resultDict["prediction"][0].toUpperCase()}${resultDict["prediction"].substring(1)}",
                        style: kDefaultStyle,
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
              padding: EdgeInsets.all(8.0),
              child: resultDict["statusCode"] == 200
                  ? Row(
                      children: <Widget>[
                        Text(
                          "Suggested fertilizer is: ",
                          style: kTopHeadingStyle,
                        ),
                        Text(
                          "${resultDict["prediction"][0].toUpperCase()}${resultDict["prediction"].substring(1)}",
                          style: kDefaultStyle,
                        ),
                      ],
                    )
                  : Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "",
                      ),
                    )),
        ],
      ),
    );
  }
}
