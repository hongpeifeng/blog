import 'package:blog/pages/article//article_page.dart';
import 'package:blog/pages/article/search_page.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class ArticleWindowNavigator extends StatefulWidget {
  @override
  ArticleWindowNavigatorState createState() => ArticleWindowNavigatorState();
}

class ArticleWindowNavigatorState extends State<ArticleWindowNavigator> {

  static const articleInboxRoute = '/home/article';
  static const articleSearchInboxRoute = '/home/article/search';

  Route _wrapper({required Widget child, required RouteSettings settings}) {
    return PageRouteBuilder<void>(
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeThroughTransition(
          fillColor: Theme.of(context).cardColor,
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      settings: settings,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Navigator(
      initialRoute: articleInboxRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case articleInboxRoute:
            return _wrapper(
              settings: settings,
              child: ArticlePage(),
            );
          case articleSearchInboxRoute:
            return _wrapper(
              settings: settings,
              child: const SearchPage(),
            );
          default:
            return null;
        }
      },
    );
  }
}
