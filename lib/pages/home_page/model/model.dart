
import 'dart:convert';
import 'package:blog/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;


class HomePageModel extends ChangeNotifier {

  List<ArticleGroupModel> _groups = [];

  List<ArticleModel> _articles = [];

  int _selectIndex = 0;

  bool _isHome = true;

  Future<void> loadLocalData() async {
    // 组
    final groupsJson = await rootBundle.loadString('assets/group.json');
    final List json = jsonDecode(groupsJson);
    _groups = json.map((e) => ArticleGroupModel.fromJson(e)).toList();

    // 文章
    final articlesJson = await rootBundle.loadString('assets/article.json');
    final List articles = jsonDecode(articlesJson);
    _articles = articles.map((e) => ArticleModel.fromJson(e)).toList();

    notifyListeners();
  }

  HomePageModel(){
    loadLocalData();
  }


  int get selectIndex => _selectIndex;
  void setSelectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  List<ArticleGroupModel> get groups => _groups;

  List<ArticleModel> get articles => _articles.where((element) => element.tag == _groups[selectIndex].name).toList();

  bool get isHome => _isHome;
  void setIsHome(bool value) {
    _isHome = value;
    notifyListeners();
  }

}