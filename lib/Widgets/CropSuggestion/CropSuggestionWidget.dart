import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../Constants/Constants.dart';

class CropSuggestionWidget extends StatefulWidget {
  @override
  _CropSuggestionWidgetState createState() => _CropSuggestionWidgetState();
}

class _CropSuggestionWidgetState extends State<CropSuggestionWidget> {
  final _key = GlobalKey<FormState>();

  int? n, p, k;
  double? temperature, humidity, pH, rainfall;

  Future<Map<String, dynamic>> predictCrop(var body) async {
    var uri =
        Uri.parse("https://farmx-crop-recommendation.herokuapp.com/croprec");

    Map<String, String> headers = {"Content-type": "application/json"};
    String jsonString = json.encode(body);

    try {
      var response = await http.post(uri, headers: headers, body: jsonString);
      var statusCode = response.statusCode;

      if (statusCode == 200) {
        print("DATA FETCHED SUCCESSFULLY");
        var result = json.decode(response.body);

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
      return Future.error("Null");
    }
    return Future.error("Null");
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
                    hintText: 'Enter a Value.',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (value) {
                  n = int.parse(value);
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
                    hintText: 'Enter a Value.',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0))),
                onChanged: (value) {
                  p = int.parse(value);
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
                  labelText: 'pH',
                  hintText: 'Enter a Value from 0 to 14.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  pH = double.parse(value);
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
                  hintText: 'Enter a Value.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  k = int.parse(value);
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
                  hintText: 'Enter a Value.',
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
                  hintText: 'Enter a Value.',
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
                  labelText: 'Rainfall',
                  hintText: 'Enter a Value.',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onChanged: (value) {
                  rainfall = double.parse(value);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ElevatedButton(
              child: Text('Submit'),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => kOrange),
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
                    'ph': pH,
                    'rainfall': rainfall
                  }
                ];
                var response = await predictCrop(body);
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
                          "Suggested crop is: ",
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

  // _onBasicAlertPressed(context, resp) {
  //   Alert(context: context, title: "Recommended Crop is", desc: resp).show();
  // }
}
