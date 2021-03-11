

import 'package:blog/pages/article/article_window_navigator.dart';
import 'package:blog/pages/home_page/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomePageMobile extends StatefulWidget {
  @override
  _HomePageMobileState createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArticleWindowNavigator(),
      bottomNavigationBar: BottomNavigationBar(),
    );
  }
}


class BottomNavigationBar extends StatefulWidget {
  @override
  _BottomNavigationBarState createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    return Selector<HomePageModel, bool>(
      selector: (context, model) => model.isHome,
      builder: (context, isHome, child) {
        return AnimatedSwitcher(duration: kThemeAnimationDuration,
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child,);
          },
          child: isHome ? Container(
            height: 30,
            color: Colors.redAccent,
          ) : const SizedBox(),
        );
      },
    );
  }
}
