//Now let's create the article details page

import 'package:farmx/Constants/Constants.dart';
import 'package:farmx/newsfeed/model/article_model.dart';
import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  final Article? article;

  ArticlePage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article!.title!),
        backgroundColor: kDarkPrimaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 10.0,
          right: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200.0,
              width: double.infinity,
              decoration: BoxDecoration(
                //let's add the height

                image: DecorationImage(
                    image: NetworkImage(article!.urlToImage!),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: kDarkSecondaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                article!.source.name!,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              article!.description!,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
