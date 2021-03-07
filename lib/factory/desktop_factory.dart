

import 'package:flutter/material.dart';
import 'package:blog/factory/app_factory.dart';
import 'package:blog/pages/home_page/home_page_desktop.dart';

class DesktopFactory extends AppFactory {

  @override
  Widget buildHomePage() {
    return HomePageDesktop();
  }

}