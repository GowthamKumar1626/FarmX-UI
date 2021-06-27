import 'package:flutter/material.dart';
//import 'package:flutter_auth/funds/view.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'cart_counter.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast() {
  Fluttertoast.showToast(
      msg: 'You liked this Item!',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white);
}

class CounterWithFavBtn extends StatelessWidget {
  const CounterWithFavBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        CartCounter(),
        Container(
          padding: EdgeInsets.all(8),
          height: 32,
          width: 32,
          decoration: BoxDecoration(
            color: Color(0xFFFF6464),
            shape: BoxShape.circle,
          ),
          child: GestureDetector(
            onTap: () {
              showToast();
            },
            child: SvgPicture.asset("assets/icons/heart.svg"),
          ),
        )
      ],
    );
  }
}
