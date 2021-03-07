import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdown_widget/markdown_widget.dart';

class ArticleDetailPage extends StatefulWidget {
  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  String markdownData = '';

  @override
  void initState() {
    rootBundle.loadString('assets/逆向总纲.md').then((value) {
      markdownData = value;
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _header(),
              const SizedBox(
                height: 12,
              ),
              _body()
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '逆向 - 15 minutes ago',
              style: textTheme.caption,
            ),
            const SizedBox(height: 4),
            Text('逆向总纲', style: textTheme.headline5),
          ],
        )),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Widget _body() {
    return MarkdownWidget(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        data: markdownData,
        styleConfig: StyleConfig(
            markdownTheme: Theme.of(context).brightness == Brightness.dark
                ? MarkdownTheme.darkTheme
                : MarkdownTheme.lightTheme));
  }

}
