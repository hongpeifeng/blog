import 'package:blog/pages/home_page/model/model.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:provider/provider.dart';

import 'article_detail_page.dart';

class ArticleItem extends StatefulWidget {
  final String category;
  final String title;
  final String createdTime;
  final String summery;
  final String markdownAddress;
  const ArticleItem({
    @required this.category,
    @required this.title,
    @required this.createdTime,
    @required this.summery,
    @required this.markdownAddress
  });
  @override
  _ArticleItemState createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        onClosed: (_){
          Provider.of<HomePageModel>(context,listen: false).setIsHome(true);
        },
        openColor: Theme.of(context).cardColor,
        closedColor: Theme.of(context).cardColor,
        closedBuilder: (context, openContainer) {
          return _ArticleItemPreview(
            onTap: openContainer,
            category: widget.category,
            title: widget.title,
            createdTime: widget.createdTime,
            summery: widget.summery,
          );
        },
        openBuilder: (context, closedContainer) {
          return ArticleDetailPage(
            markdownAddress: widget.markdownAddress,
          );
        });
  }
}

class _ArticleItemPreview extends StatefulWidget {
  final VoidCallback onTap;
  final String category;
  final String title;
  final String createdTime;
  final String summery;

  const _ArticleItemPreview({
    @required this.onTap,
    @required this.category,
    @required this.title,
    @required this.createdTime,
    @required this.summery,
  });

  @override
  __ArticleItemPreviewState createState() => __ArticleItemPreviewState();
}

class __ArticleItemPreviewState extends State<_ArticleItemPreview> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        widget.onTap();
        Provider.of<HomePageModel>(context,listen: false).setIsHome(false);
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
              constraints: BoxConstraints(maxHeight: constraints.maxHeight),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${widget.category} - ${widget.createdTime}',
                      style: textTheme.caption,
                    ),
                    const SizedBox(height: 4),
                    Text(widget.title ?? '', style: textTheme.headline5),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 20,
                      ),
                      child: Text(
                        widget.summery ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: textTheme.bodyText2,
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }
}
