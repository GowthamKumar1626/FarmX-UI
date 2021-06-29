import 'package:farmx/Widgets/PestDetection/Crops/crops.dart';
import 'package:farmx/widgets/Tools/constants.dart';
import 'package:flutter/material.dart';

class CropCard extends StatelessWidget {
  final Crops crops;
  final Function press;
  const CropCard({
    Key? key,
    required this.crops,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => press(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.all(kDefaultPaddin),
              // For  demo we use fixed height  and width
              // Now we dont need them
              // height: 180,
              // width: 160,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${crops.name}",
                child: Image(
                  image: AssetImage(crops.imagePath),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
            child: Text(
              crops.name,
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
