import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';

class TFModelScreen extends StatelessWidget {
  const TFModelScreen({Key? key, required this.cropName}) : super(key: key);
  final String cropName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pest Detection"),
        centerTitle: true,
        backgroundColor: kBlack,
      ),
    );
  }
}
