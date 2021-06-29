List<Crops> pestCrops = [
  Crops(
    name: "Apple",
    imagePath: "assets/images/apple.png",
  ),
  Crops(
    name: "Grapes",
    imagePath: "assets/images/grapes.jpeg",
  ),
  Crops(
    name: "Potato",
    imagePath: "assets/images/potato.jpeg",
  ),
  Crops(
    name: "tomato",
    imagePath: "assets/images/tomato.jpeg",
  ),
  Crops(
    name: "BlueBerry",
    imagePath: "assets/images/blueberry.jpeg",
  ),
];

class Crops {
  Crops({
    required this.name,
    required this.imagePath,
  });
  String name;
  String imagePath;
}
