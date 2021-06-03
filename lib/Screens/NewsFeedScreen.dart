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
        title: Text("News Feed", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      //Now let's call the APi services with futurebuilder wiget
      body: FutureBuilder(
        future: client.getArticle(),
        builder: (BuildContext context, AsyncSnapshot<List<Article>> snapshot) {
          //let's check if we got a response or not
          if (snapshot.hasData) {
            //Now let's make a list of articles
            Text("hii");
            List<Article> articles = snapshot.data!;
            return ListView.builder(
              //Now let's create our custom List tile
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
    );
  }
}
