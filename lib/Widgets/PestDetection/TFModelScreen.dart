import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Widgets/PestDetection/Crops/crops.dart';
import 'package:farmx/Widgets/PestDetection/PestModel.dart';
import 'package:flutter/material.dart';

class TFModelScreen extends StatelessWidget {
  const TFModelScreen({Key? key, required this.cropIndex}) : super(key: key);
  final int cropIndex;

  @override
  Widget build(BuildContext context) {
    print(cropIndex);
    return Scaffold(
      appBar: AppBar(
        title: Text("Pest Detection"),
        centerTitle: true,
        backgroundColor: kBlack,
      ),
      body: PestModel(
        modelPath: pestCrops[cropIndex].modelPath,
        labelPath: pestCrops[cropIndex].labelPath,
      ),
    );
  }
}
