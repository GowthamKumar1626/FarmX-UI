import 'package:flutter/material.dart';

class TimePickerScreen extends StatelessWidget {
  const TimePickerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick your timings"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
