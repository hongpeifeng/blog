import 'package:blog/model/model.dart';
import 'package:blog/pages/article/article_window_navigator.dart';
import 'package:blog/pages/home_page/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                  color: isDark ? Theme.of(context).backgroundColor : Colors.white,
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
                              onPressed: () async {
                                final index = await showBottomAcitons(context,
                                    actions: tuple.item1
                                        .map((e) => Action(e.iconAddress, e.name))
                                        .toList(),selectedIndex: tuple.item2);
                                if (index != null) tuple.item3(index);
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

class Action {
  String icon;
  String title;

  Action(this.icon, this.title);
}

Future<int> showBottomAcitons(BuildContext context, {List<Action> actions, int selectedIndex = 0}) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return showSlidingBottomSheet(context, builder: (context) {
    return SlidingSheetDialog(
      duration: kThemeAnimationDuration,
      color: Colors.transparent,
        headerBuilder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          color: isDark ? Theme.of(context).backgroundColor : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16))
        ),
        height: 15,
      );
    }, builder: (context, state) {
      return Material(
        color: isDark ? Theme.of(context).backgroundColor : Colors.white,
        shadowColor: isDark ? Theme.of(context).backgroundColor : Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  final Color color = selectedIndex == index ? Theme.of(context).accentColor : Theme.of(context).textTheme.bodyText2.color;
                  return InkWell(
                    onTap: () => Navigator.of(context).pop(index),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            actions[index].icon,
                            color: color,
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(width: 16,),
                          Text(actions[index].title, style: Theme.of(context).textTheme.bodyText2.copyWith(color: color))
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ),
      );
    }
    );
  });
}
