
import 'package:blog/main.dart';
import 'package:blog/themes/utils.dart';
import 'package:flutter/material.dart';

import 'factory/app_factory.dart';
import 'factory/desktop_factory.dart';
import 'factory/mobile_factory.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {


  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((d) {
      appFactory ??= isDisplayDesktop(context) ? DesktopFactory() : MobileFactory();
      Navigator.of(context).pushNamed(BlogApp.homeRoute);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
