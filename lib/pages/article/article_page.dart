import 'package:blog/pages/article//article_item.dart';
import 'package:flutter/material.dart';

import 'article_window_navigator.dart';



class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: ListView.separated(
          itemCount: 4,
          padding: const EdgeInsetsDirectional.only(
            start: 60,
            end: 30,
            top: 28,
            bottom: kToolbarHeight,
          ),
          primary: false,
          separatorBuilder: (context, index) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            return ArticleItem();
          },
        )),
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20),
          child: IconButton(icon: const Icon(Icons.search), onPressed: () => Navigator.of(context).pushNamed(ArticleWindowNavigatorState.articleSearchInboxRoute)),
        )
      ],
    ));
  }
}
