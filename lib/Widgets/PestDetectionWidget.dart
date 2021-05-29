import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
        Center(
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
        FloatingActionButton(
          onPressed: getImage,
          tooltip: 'Pick Image',
          child: Icon(Icons.add_a_photo),
        ),
      ],
    );
  }
}
