
import 'package:blog/model/model.dart';
import 'package:blog/pages/article/main_window_navigator.dart';
import 'package:blog/pages/home_page/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _controller = TextEditingController();
  List<ArticleModel> _articles = [];

  @override
  void initState() {
    _controller.addListener(() async {
      _articles = _controller.text.isEmpty ? [] : await Provider.of<HomePageModel>(context,listen: false).searchArticleByKeyword(_controller.text);
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration.collapsed(
                        hintText: '关键字搜索',
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
          ),
          const Divider(thickness: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _articles.map((e) => _SearchHistoryTile(
                  svgAddress: e.imageAddress,
                  title: e.articleName,
                  subtitle: e.summary,
                  onTap: () {
                    Navigator.of(context).popAndPushNamed(MainWindowNavigatorState.articleDetailRoute,arguments: {
                      'markdownAddress': e.articleAddress,
                      'category': e.tag,
                      'title': e.articleName,
                      'createdTime': e.createTime,
                    });
                  },
                )).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }


}


class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    @required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        top: 16,
        bottom: 16,
      ),
      child: Text(
        title,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }
}

class _SearchHistoryTile extends StatelessWidget {
  const _SearchHistoryTile({
    this.svgAddress,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
  });

  final String svgAddress;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(svgAddress, height: 24, width: 24, color: Theme.of(context).textTheme.bodyText2.color,),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
