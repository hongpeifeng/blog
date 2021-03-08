import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

import 'article_detail_page.dart';

class ArticleItem extends StatefulWidget {
  @override
  _ArticleItemState createState() => _ArticleItemState();
}

class _ArticleItemState extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
        openColor: Theme.of(context).cardColor,
        closedColor: Theme.of(context).cardColor,
        closedBuilder: (context, openContainer) {
          return _ArticleItemPreview(
            onTap: openContainer,
          );
        },
        openBuilder: (context, closedContainer) {
          return ArticleDetailPage();
        });
  }
}

class _ArticleItemPreview extends StatefulWidget {
  final VoidCallback onTap;

  const _ArticleItemPreview({@required this.onTap});

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
                      '逆向 - 15 分钟前',
                      style: textTheme.caption,
                    ),
                    const SizedBox(height: 4),
                    Text('总纲', style: textTheme.headline5),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        end: 20,
                      ),
                      child: Text(
                        '因为我大学期间开发游戏外挂，对于逆向的强大有过不小的认识。能让别人的代码照着自己的思路去走，感觉是蛮好玩的一件事。所以带着好奇心去研究了iOS逆向。对于iOS逆向，很多人只听过《IOS应用逆向工程》，单纯通过书籍还有杂乱的博文，想要入门还是挺难的。其实iOS逆向没想象中那么难，只要我们找到方法。你想想【游戏外挂】只是单纯凭借C++基础/数据结构去逆向一个大型网游，而现在我们有过正向iOS开发经验，逆向苹果App，难度可想而知降了多少。'
                        '我们正常的开发是从代码->UI/功能,逆向就是从UI/功能反推回代码。这段时间断断续续学了不少iOS逆向的知识,准备好好整理一遍，分享出来，如有错误欢迎指正！',
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
