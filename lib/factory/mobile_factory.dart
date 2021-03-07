

import 'package:flutter/material.dart';
import 'package:blog/factory/app_factory.dart';
import 'package:blog/pages/home_page/home_page_mobile.dart';

class MobileFactory extends AppFactory {

  @override
  Widget buildHomePage() {
    return HomePageMobile();
  }

}