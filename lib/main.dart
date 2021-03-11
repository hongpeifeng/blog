
import 'package:blog/themes/dart_theme.dart';
import 'package:blog/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'pages/home_page/home_page.dart';

void main() {
  runApp(const BlogApp());
}

class BlogApp extends StatefulWidget {
  const BlogApp();

  static const String homeRoute = '/home';

  @override
  _BlogAppState createState() => _BlogAppState();
}

class _BlogAppState extends State<BlogApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Blog',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: BlogApp.homeRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case BlogApp.homeRoute:
            return MaterialPageRoute<void>(
              builder: (context) => HomePage(),
              settings: settings,
            );
        }
        return null;
      },
    );
  }
}