import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast() {
  Fluttertoast.showToast(
      msg: 'Thanks for buying!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[600],
      textColor: Colors.white);
}

class Buynow extends StatelessWidget {
  //get child => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Buy Now'),
        centerTitle: true,
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text(
                    'Here are your items seleted , chick the button to proceed')),
            Center(
                child: RaisedButton(
              color: Colors.purple[200],
              onPressed: () {
                showToast();
              },
              child: new Text('PROCEED'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              textColor: Colors.black,
            )),
          ],
        ),
      ),
    );
  }
}
