import 'package:blog/model/model.dart';
import 'package:blog/pages/article/widgets/article_item.dart';
import 'package:blog/pages/home_page/model/model.dart';
import 'package:blog/themes/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main_window_navigator.dart';

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = isDisplayDesktop(context);

    return Scaffold(
        body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Selector<HomePageModel, List<ArticleModel>>(
                selector: (_, model) => model.articles,
                builder: (context, articles, child) {
                  print(articles);
                  return ListView.separated(
                    itemCount: articles.length,
                    padding: EdgeInsetsDirectional.only(
                      start: isDesktop ? 60 : 8,
                      end: isDesktop ? 30 : 8,
                      top: isDesktop ? 28 : 12,
                      bottom: kToolbarHeight,
                    ),
                    primary: false,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 4),
                    itemBuilder: (context, index) {
                      return ArticleItem(
                        category: articles[index].tag,
                        title: articles[index].articleName,
                        createdTime: articles[index].createTime,
                        summery: articles[index].summary,
                        markdownAddress: articles[index].articleAddress,
                        svgAdress: articles[index].imageAddress,
                      );
                    },
                  );
                })),
        if (isDesktop)
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 20),
            child: IconButton(
                icon: const Icon(Icons.search),
                onPressed: () => Navigator.of(context).pushNamed(
                    MainWindowNavigatorState.articleSearchInboxRoute)),
          )
      ],
    ));
  }
}
