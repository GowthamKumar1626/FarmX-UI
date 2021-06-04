import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/newsfeed/components/customListTile.dart';
import 'package:farmx/newsfeed/model/article_model.dart';
import 'package:farmx/newsfeed/services/api_service.dart';
import 'package:flutter/material.dart';

class NewsFeedScreen extends StatefulWidget {
  static const id = "news_feed";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewsFeedScreen> {
  ApiService client = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News Feed", style: TextStyle(color: Colors.white)),
        backgroundColor: kDarkPrimaryColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.0),
            topRight: Radius.circular(45.0),
          ),
          color: Colors.white,
        ),
        height: MediaQuery.of(context).size.height - 100.0,
        width: MediaQuery.of(context).size.width,
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
                color: Colors.black,
              ),
              // child: new Text("Loading"),
            );
          },
        ),
      ),
    );
  }
}
