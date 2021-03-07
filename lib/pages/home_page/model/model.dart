
import 'package:flutter/material.dart';


class NavigationItem {
  const NavigationItem({
    required this.textLabel,
    required this.icon,
  });

  final String textLabel;
  final IconData icon;


  NavigationRailDestination toDestination() {
    return NavigationRailDestination(
      icon: Icon(
        icon
      ),
      label: Text(textLabel)
    );
  }
}

class HomePageModel extends ChangeNotifier {

  List<NavigationItem> navigationItems = [];

  int _selectIndex = 0;

  HomePageModel(){
    navigationItems = [
      const NavigationItem(textLabel: '主页', icon: Icons.home),
      const NavigationItem(textLabel: '其他', icon: Icons.more_horiz),
    ];
  }


  int get selectIndex => _selectIndex;
  void setSelectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

}