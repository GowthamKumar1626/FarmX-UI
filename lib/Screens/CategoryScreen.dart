import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../Constants/Constants.dart';
import '../Constants/Tools.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = "category_screen";

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int currentIndex = 1;
  String title = "Tools";

  final _auth = FirebaseAuth.instance;
  User? loggedInUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    final user = _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
      print(loggedInUser!.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 25,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    customBorder: CircleBorder(),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      await _auth.signOut();
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      backgroundImage: AssetImage("assets/icons/user.png"),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Hey User",
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 17,
                  color: kGrey,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Know more about our tools',
                style: kGreetingsStyle,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CategoryButton(
                    image: AssetImage("assets/icons/pest-detection.png"),
                    color: kGreen,
                    onPressed: () {
                      setState(() {
                        currentIndex = 1;
                        title = "Pest Detection";
                      });
                    },
                    isSelected: currentIndex == 1,
                  ),
                  CategoryButton(
                    image: AssetImage("assets/icons/fertilizer.png"),
                    color: kOrange,
                    onPressed: () {
                      setState(() {
                        currentIndex = 2;
                        title = "Fertlizer Recommendation";
                      });
                    },
                    isSelected: currentIndex == 2,
                  ),
                  CategoryButton(
                    image: AssetImage("assets/icons/crop-suggestion.png"),
                    color: kBlue,
                    onPressed: () {
                      setState(() {
                        currentIndex = 3;
                        title = "Crop Suggestion";
                      });
                    },
                    isSelected: currentIndex == 3,
                  ),
                  CategoryButton(
                    image: AssetImage("assets/icons/recommendation.png"),
                    color: kYellow,
                    onPressed: () {
                      setState(() {
                        currentIndex = 4;
                        title = "Recommendation";
                      });
                    },
                    isSelected: currentIndex == 4,
                  ),
                  CategoryButton(
                    image: AssetImage("assets/icons/donate.png"),
                    color: kPink,
                    onPressed: () {
                      setState(() {
                        currentIndex = 5;
                        title = "Funds & Donations";
                      });
                    },
                    isSelected: currentIndex == 5,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: kToolSelected,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Tools",
                style: kTopHeadingStyle,
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: StaggeredGridView.countBuilder(
                  itemCount: tools.length,
                  crossAxisSpacing: 6,
                  mainAxisSpacing: 6,
                  crossAxisCount: 4,
                  itemBuilder: (context, index) {
                    return ToolContainer(
                      index: index,
                    );
                  },
                  staggeredTileBuilder: (index) {
                    return StaggeredTile.count(2, index.isEven ? 3 : 2);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ToolContainer extends StatelessWidget {
  final int index;

  ToolContainer({required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kLightGrey,
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: AssetImage(
            tools[index].imgPath,
          ),
          fit: tools[index].imgFit,
        ),
      ),
      child: Column(
        children: <Widget>[
          // Text(
          //   tools[index].name,
          //   style: kPlaceStyle,
          // ),
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(2),
              ),
              Icon(
                Icons.toll_outlined,
                color: Colors.pinkAccent,
              ),
              Expanded(
                child: Text(
                  tools[index].name,
                  style: tools[index].colorStyle,
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(5),
                child: Container(
                  padding: EdgeInsets.only(left: 5),
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                        child: TextButton(
                          onPressed: () {
                            print("Clicked");
                          },
                          child: Text(
                            'Launch',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Icon(
                          Icons.arrow_right,
                          color: Colors.black,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final AssetImage image;
  final Color color;
  final Function() onPressed;
  final bool isSelected;

  CategoryButton({
    required this.image,
    required this.color,
    required this.onPressed,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0,
      highlightElevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      fillColor: isSelected ? color.withAlpha(100) : kLightGrey,
      constraints: BoxConstraints.tightFor(
        width: 70,
        height: 75,
      ),
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: image,
      ),
      // child: Icon(
      //   icon,
      //   size: 30,
      //   color: color,
      // ),
    );
  }
}
