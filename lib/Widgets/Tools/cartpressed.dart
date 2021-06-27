import 'package:flutter/material.dart';

// ignore: camel_case_types
class cartbuttonpressed extends StatefulWidget {
  @override
  _ClickoncartState createState() => _ClickoncartState();
}

class _ClickoncartState extends State<cartbuttonpressed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.purpleAccent[200],
        centerTitle: true,
        title: new Text('CART'),
        /*actions: [
          Image.asset("assets/icons/cart.svg"),
        ],*/
      ),
      body: Center(child: new Text('Here is your cart and your items added')),
    );
  }
}
