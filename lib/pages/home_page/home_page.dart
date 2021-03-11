import 'package:blog/pages/home_page/home_page_desktop.dart';
import 'package:blog/pages/home_page/home_page_mobile.dart';
import 'package:blog/themes/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageModel _model = HomePageModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: isDisplayDesktop(context) ? HomePageDesktop() : HomePageMobile(),
    );
  }
}
