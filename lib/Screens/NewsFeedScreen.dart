import 'package:flutter/material.dart';

class NewsFeedScreen extends StatefulWidget {
  static const id = "newsfeed_screen";

  @override
  _NewsFeedScreenState createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("NewsFeed Screen"),
      ),
    );
  }
}
