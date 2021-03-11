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
                IconButton(icon: const Icon(Icons.list), onPressed: (){
                  showBottomSheet(context: context, builder: (context){
                    return Selector<HomePageModel, Tuple3<List<ArticleGroupModel>, int, Function(int)>>(
                      selector: (context, model) =>
                          Tuple3(model.groups, model.selectIndex, model.setSelectIndex),
                      builder: (context, tuple, child) {
                        final items = tuple.item1;
                        final selectIndex = tuple.item2;
                        if (items.length < 2) {
                          return const SizedBox();
                        }
                        return Container(
                          height: 100,
                          child: ListView.separated(itemBuilder: (ctx, index) {
                            return Text(tuple.item1[index].name);
                          }, separatorBuilder: (context, index) => const SizedBox(height: 4,), itemCount: tuple.item1.length),
                        );

                      },
                    );
                  });
                }),
                IconButton(icon: const Icon(Icons.search), onPressed: (){
                  articleWindowKey.currentState.pushNamed(ArticleWindowNavigatorState.articleSearchInboxRoute);
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
