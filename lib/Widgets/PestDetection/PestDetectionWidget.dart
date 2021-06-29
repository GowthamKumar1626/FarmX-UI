import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/Widgets/PestDetection/PestCropsScreen.dart';
import 'package:flutter/material.dart';

class PestDetectionWidget extends StatefulWidget {
  @override
  _PestDetectionWidgetState createState() => _PestDetectionWidgetState();
}

class _PestDetectionWidgetState extends State<PestDetectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                "About",
                style: kTopHeadingStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              // padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width * 0.8,
              child: new Column(
                children: <Widget>[
                  new Text(
                      "Pest Detection is a powerful tool designed using AI. It detects around 38 different pests.",
                      textAlign: TextAlign.left),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => PestCropsScreen(),
                  ),
                );
              },
              child: Text("Visit"),
            ),
          ],
        ),
      ],
    );
  }
}
