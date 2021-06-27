import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:farmx/widgets/Tools/constants.dart';
import 'package:farmx/widgets/Tools/products.dart';
import 'package:farmx/widgets/Tools/buynow.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast() {
  Fluttertoast.showToast(
      msg: 'You Added This Item To Cart',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white);
}

class AddToCart extends StatelessWidget {
  const AddToCart({
    required Key key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: kDefaultPaddin),
            height: 50,
            width: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                  //color: Colors.purple[300],

                  ),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/add_to_cart.svg",
                color: Colors.purple[300],
              ),
              onPressed: showToast,
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 50,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                color: Colors.purple[300],
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Buynow();
                      },
                    ),
                  );
                },
                child: Text(
                  "Buy  Now".toUpperCase(),
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
