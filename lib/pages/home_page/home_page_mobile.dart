import 'package:blog/model/model.dart';
import 'package:blog/pages/article/article_window_navigator.dart';
import 'package:blog/pages/home_page/model/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

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

class BottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Selector<HomePageModel, bool>(
      selector: (context, model) => model.isHome,
      builder: (context, isHome, child) {
        return AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          transitionBuilder: (child, animation) => SizeTransition(
            sizeFactor: animation,
            child: child,
          ),
          child: isHome
              ? Container(
                  height: 44,
                  color: Theme.of(context).backgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Selector<HomePageModel,
                          Tuple3<List<ArticleGroupModel>, int, Function(int)>>(
                        selector: (context, model) => Tuple3(model.groups,
                            model.selectIndex, model.setSelectIndex),
                        builder: (context, tuple, child) {
                          return IconButton(
                              icon: const Icon(Icons.list),
                              onPressed: () {

                              });
                        },
                      ),
                      IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            articleWindowKey.currentState.pushNamed(
                                ArticleWindowNavigatorState
                                    .articleSearchInboxRoute);
                          })
                    ],
                  ),
                )
              : const SizedBox(),
        );
      },
    );
  }
}
