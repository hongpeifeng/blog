import 'package:blog/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:markdown_widget/markdown_widget.dart';

class ArticleDetailPage extends StatefulWidget {
  final String category;
  final String title;
  final String createdTime;
  final String markdownAddress;

  const ArticleDetailPage({
    @required this.category,
    @required this.title,
    @required this.createdTime,
    @required this.markdownAddress,
  });

  @override
  _ArticleDetailPageState createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  String markdownData = '';

  Future _future;

  @override
  void initState() {
    _future = () async {
      await Future.delayed(const Duration(milliseconds: 400));
      return loadArticleContent(widget.markdownAddress);
    }();
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
              const SizedBox(height: 12),
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
              '${widget.category} - ${widget.createdTime}',
              style: textTheme.caption,
            ),
            const SizedBox(height: 4),
            Text(widget.title, style: textTheme.headline5),
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
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return MarkdownWidget(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              data: snapshot.data,
              styleConfig: StyleConfig(
                  markdownTheme: Theme.of(context).brightness == Brightness.dark
                      ? MarkdownTheme.darkTheme
                      : MarkdownTheme.lightTheme));
        });
  }
}
