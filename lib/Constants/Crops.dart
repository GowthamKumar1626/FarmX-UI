List<Crops> crops = [
  Crops(
    cropName: "Paddy",
    imgPath: "assets/icons/sprout.png",
  ),
  Crops(
    cropName: "Chilli",
    imgPath: "assets/icons/chilli-pepper.png",
  ),
  Crops(
    cropName: "Wheat",
    imgPath: "assets/icons/grain.png",
  ),
  Crops(
    cropName: "Cotton",
    imgPath: "assets/icons/cotton.png",
  ),
  Crops(
    cropName: "Paddy",
    imgPath: "assets/icons/sprout.png",
  ),
  Crops(
    cropName: "Paddy",
    imgPath: "assets/icons/sprout.png",
  ),
];

class Crops {
  String cropName;
  String imgPath;

  Crops({
    required this.cropName,
    required this.imgPath,
  });
}
