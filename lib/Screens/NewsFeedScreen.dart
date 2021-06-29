import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/newsfeed/components/customListTile.dart';
import 'package:farmx/newsfeed/model/article_model.dart';
import 'package:farmx/newsfeed/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class NewsFeedScreen extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewsFeedScreen> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    return Scaffold(
      backgroundColor: kDarkPrimaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kDarkPrimaryColor,
        elevation: 0.0,
        title: Text(
          "NewsFeed",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Roboto',
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: FutureBuilder(
          future: client.getArticle(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
            if (snapshot.hasData) {
              List<Article> articles = snapshot.data!;
              return ListView.builder(
                itemCount: articles.length,
                itemBuilder: (context, index) =>
                    customListTile(articles[index], context),
              );
            }
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
              // child: new Text("Loading"),
            );
          },
        ),
      ),
    );
  }
}
