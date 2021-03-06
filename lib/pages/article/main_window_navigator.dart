import 'package:blog/pages/article//article_page.dart';
import 'package:blog/pages/article/search_page.dart';
import 'package:blog/pages/home_page/model/model.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

import 'article_detail_page.dart';

final articleWindowKey = GlobalKey<NavigatorState>();


class MainWindowNavigator extends StatefulWidget {
  @override
  MainWindowNavigatorState createState() => MainWindowNavigatorState();
}

class MainWindowNavigatorState extends State<MainWindowNavigator> {

  static const articleInboxRoute = '/home/article';
  static const articleDetailRoute = '/home/article/detail';
  static const articleSearchInboxRoute = '/home/article/search';

  Route _wrapper({@required Widget child, @required RouteSettings settings}) {
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
      key: articleWindowKey,
      initialRoute: articleInboxRoute,
      observers: [
        _NavigatorObserver(context: context)
      ],
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
              child: SearchPage(),
            );
          case articleDetailRoute:
            final Map arguments = settings.arguments;
            return _wrapper(
              settings: settings,
              child: ArticleDetailPage(
                markdownAddress: arguments['markdownAddress'],
                category: arguments['category'],
                title: arguments['title'],
                createdTime: arguments['createdTime'],
              )
            );
          default:
            return null;
        }
      },
    );
  }
}



class _NavigatorObserver extends NavigatorObserver {

  final BuildContext context;

  _NavigatorObserver({
    @required this.context,
  });

  void updateModel(String routeName){
    Provider.of<HomePageModel>(context, listen: false).setIsHome(routeName == MainWindowNavigatorState.articleInboxRoute);
  }

  @override
  void didPush(Route route, Route previousRoute) {
    if (route.settings.name != MainWindowNavigatorState.articleInboxRoute) {
      updateModel(route.settings.name);
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route previousRoute) {
    updateModel(previousRoute.settings.name);
    super.didPop(route, previousRoute);
  }

}