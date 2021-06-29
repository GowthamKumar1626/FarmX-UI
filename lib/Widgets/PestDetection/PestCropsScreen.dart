import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';

import 'CropCard.dart';
import 'Crops/crops.dart';
import 'TFModelScreen.dart';

class PestCropsScreen extends StatefulWidget {
  const PestCropsScreen({Key? key}) : super(key: key);

  @override
  _PestCropsScreenState createState() => _PestCropsScreenState();
}

class _PestCropsScreenState extends State<PestCropsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pest Detection"),
        centerTitle: true,
        backgroundColor: kBlack,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: pestCrops.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 15.0,
            childAspectRatio: 0.5,
          ),
          itemBuilder: (context, index) => CropCard(
            crops: pestCrops[index],
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => TFModelScreen(
                  cropIndex: index,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
