import 'package:blog/pages/article/article_window_navigator.dart';
import 'package:flutter/material.dart';
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
  final HomePageModel _model = HomePageModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ChangeNotifierProvider.value(
        value: _model,
        child: Row(
          children: [
            Selector<HomePageModel, Tuple2<List<NavigationItem>, int>>(
              selector: (context, model) =>
                  Tuple2(model.navigationItems, model.selectIndex),
              builder: (context, tuple, child) {
                final items = tuple.item1;
                final selectIndex = tuple.item2;
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
                              destinations:
                                  items.map((e) => e.toDestination()).toList(),
                              selectedIndex: selectIndex,
                              onDestinationSelected: _model.setSelectIndex,
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
      ),
    );
  }
}

class _NavigationHeader extends StatelessWidget {

  final ValueNotifier<bool> isExtended;

  const _NavigationHeader({
    required this.isExtended,
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
                                          .headline5!
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
