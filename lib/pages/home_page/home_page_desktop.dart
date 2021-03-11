import 'package:blog/model/model.dart';
import 'package:blog/pages/article/article_window_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:tuple/tuple.dart';
import 'model/model.dart';

class HomePageDesktop extends StatefulWidget {
  @override
  _HomePageDesktopState createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {
  final ValueNotifier<bool> _isExtended = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
  }

  NavigationRailDestination toDestination(ArticleGroupModel model) {
    return NavigationRailDestination(
        icon: SvgPicture.asset(model.iconAddress, color: Colors.grey, width: 32, height: 32,),
        selectedIcon: SvgPicture.asset(model.iconAddress, color: Theme.of(context).primaryColor, width: 32, height: 32,),
        label: Text(model.name)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Row(
        children: [
          Selector<HomePageModel, Tuple3<List<ArticleGroupModel>, int, Function(int)>>(
            selector: (context, model) =>
                Tuple3(model.groups, model.selectIndex, model.setSelectIndex),
            builder: (context, tuple, child) {
              final items = tuple.item1;
              final selectIndex = tuple.item2;
              if (items.length < 2) {
                return const SizedBox();
              }
              return LayoutBuilder(builder: (context, constraints) {
                return Container(
                  color: Theme.of(context).backgroundColor,
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: constraints.maxHeight,
                      ),
                      child: ValueListenableBuilder<bool>(
                        valueListenable: _isExtended,
                        builder: (context, value, child) {
                          return NavigationRail(
                            leading: _NavigationHeader(isExtended: _isExtended,),
                            extended: value,
                            destinations: items.map(toDestination).toList(),
                            selectedIndex: selectIndex,
                            onDestinationSelected: tuple.item3,
                          );
                        },
                      ),
                    ),
                  ),
                );
              });
            },
          ),
          const VerticalDivider(
            thickness: 1,
            width: 1,
          ),
          Expanded(
              child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1340),
              child: ArticleWindowNavigator(),
            ),
          ))
        ],
      ),
    );
  }
}

class _NavigationHeader extends StatelessWidget {

  final ValueNotifier<bool> isExtended;

  const _NavigationHeader({
    @required this.isExtended,
  });

  @override
  Widget build(BuildContext context) {
    final animation = NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16,),
                Container(
                  height: 56,
                  padding: const EdgeInsets.only(left: 8),
                  child: animation.value == 0
                      ? FloatingActionButton(
                          onPressed: () => isExtended.value = !isExtended.value,
                          child: const Icon(Icons.explicit),
                        )
                      : Align(
                          child: FloatingActionButton.extended(
                              onPressed: () => isExtended.value = !isExtended.value,
                              label: Row(
                                children: [
                                  const Icon(Icons.explicit),
                                  SizedBox(
                                    width: 16 * animation.value,
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    widthFactor: animation.value,
                                    child: Text(
                                      'Expand',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5
                                          .copyWith(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSecondary,
                                          ),
                                    ),
                                  )
                                ],
                              )),
                        ),
                )
              ],
            ),
          );
        });
  }
}
