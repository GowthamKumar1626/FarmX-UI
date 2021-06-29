List<Crops> pestCrops = [
  Crops(
    name: "Apple",
    imagePath: "assets/images/apple.png",
    modelPath: "assets/models/apple_model/apple_model.tflite",
    labelPath: "assets/models/apple_model/labels.txt",
  ),
  Crops(
    name: "Grapes",
    imagePath: "assets/images/grapes.jpeg",
    modelPath: "assets/models/grapes_model/grapes_model.tflite",
    labelPath: "assets/models/grapes_model/labels.txt",
  ),
  Crops(
    name: "Potato",
    imagePath: "assets/images/potato.jpeg",
    modelPath: "assets/models/potato_model/potato_model.tflite",
    labelPath: "assets/models/potato_model/labels.txt",
  ),
  Crops(
    name: "tomato",
    imagePath: "assets/images/tomato.jpeg",
    modelPath: "assets/models/tomato_model/tomato_model.tflite",
    labelPath: "assets/models/blueberry_model/labels.txt",
  ),
  Crops(
    name: "BlueBerry",
    imagePath: "assets/images/blueberry.jpeg",
    modelPath: "assets/models/blueberry_model/blueberry_model.tflite",
    labelPath: "assets/models/blueberry_model/labels.txt",
  ),
];

class Crops {
  Crops({
    required this.name,
    required this.imagePath,
    required this.modelPath,
    required this.labelPath,
  });
  String name;
  String imagePath;
  String modelPath;
  String labelPath;
}
