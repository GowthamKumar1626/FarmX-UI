import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Help and Support"),
        elevation: 0,
        backgroundColor: kDarkPrimaryColor,
      ),
    );
  }
}
