import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Constants/Constants.dart';

class PestDetectionWidget extends StatefulWidget {
  @override
  _PestDetectionWidgetState createState() => _PestDetectionWidgetState();
}

class _PestDetectionWidgetState extends State<PestDetectionWidget> {
  var _image;
  final imagePicker = ImagePicker();
  Future getImage() async {
    final pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "About",
                style: kTopHeadingStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: new Column(
                children: <Widget>[
                  new Text(
                      "Pest Detection is a powerful tool designed using AI. It detects around 38 different pests.",
                      textAlign: TextAlign.left),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                "How to use",
                style: kTopHeadingStyle,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.8,
              child: new Column(
                children: <Widget>[
                  new Text(
                    "1. Click on the camera button shown below.  ",
                    textAlign: TextAlign.left,
                  ),
                  new Text("2. Capture the part of plant effected by pest.",
                      textAlign: TextAlign.left),
                  new Text(
                      "3. Run the test.                                                 ",
                      textAlign: TextAlign.left),
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.center,
          child: Center(
            // ignore: unnecessary_null_comparison
            child: _image == null
                ? Text(
                    "No image Selected",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  )
                : Image.file(_image),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Run test"),
            ),
          ],
        ),
      ],
    );
  }
}
