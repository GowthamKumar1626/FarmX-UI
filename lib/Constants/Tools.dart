import 'package:flutter/material.dart';
import '../Constants/Constants.dart';

List<Tool> tools = [
  Tool(
    name: 'Pest Detection',
    imgPath: 'assets/images/pest.jpeg',
    imgFit: BoxFit.cover,
    colorStyle: kPlaceStyle,
  ),
  Tool(
    name: 'Fertilizer',
    imgPath: 'assets/images/fertilizers.jpeg',
    imgFit: BoxFit.fill,
    colorStyle: kPlaceStyle,
  ),
  Tool(
    name: 'Crop Suggestion',
    imgPath: 'assets/images/crop-suggestion.jpeg',
    imgFit: BoxFit.cover,
    colorStyle: kToolNameStyleBlack,
  ),
  Tool(
    name: 'Co-Farming',
    imgPath: 'assets/images/co-farming.jpeg',
    imgFit: BoxFit.cover,
    colorStyle: kToolNameStyleBlack,
  ),
  Tool(
    name: 'Soil',
    imgPath: 'assets/images/soil.jpeg',
    imgFit: BoxFit.cover,
    colorStyle: kPlaceStyle,
  ),
];

class Tool {
  String name;
  String imgPath;
  final BoxFit imgFit;
  TextStyle colorStyle;

  Tool(
      {required this.name,
      required this.imgPath,
      required this.imgFit,
      required this.colorStyle});
}
