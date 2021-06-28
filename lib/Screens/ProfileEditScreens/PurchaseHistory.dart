import 'package:farmx/Constants/Constants.dart';
import 'package:flutter/material.dart';

class PurchaseHistory extends StatelessWidget {
  const PurchaseHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase history"),
        elevation: 0,
        backgroundColor: kDarkPrimaryColor,
      ),
    );
  }
}
