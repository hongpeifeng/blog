import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:blog/model/model.dart';
import 'package:markdown/markdown.dart' as m;

void main() {
  const imgsPath = 'assets/imgs';
  const markDownsPath = 'assets/markdowns';

  ///将node中的text添加到一起
  String addNodeText(m.Node node, String text) {
    if (node == null) return '';
    if (node is m.Text) {
      return '${node.text} ';
    } else if (node is m.Element) {
      if (node.children == null) return '';
      if (node.tag == 'img' || node.tag == 'a') return '';
      node.children.forEach((n) {
        text += addNodeText(n, '');
      });
    }
    return text;
  }

  String getSummery(String article) {
    final m.Document document = m.Document(
      extensionSet: m.ExtensionSet.gitHubFlavored,
      encodeHtml: false,
    );
    final nodes = document.parseLines(article.split(RegExp(r'\r?\n')));
    String sub = "";
    nodes.forEach((element) {
      sub += addNodeText(element, '');
    });
    return sub.substring(0, min(sub.length, 50));
  }

  test('生成配置', () {
    // 遍历文件夹，生成文章类型, 文章中的icon.svg, 为其图标
    final List<ArticleGroupModel> groups = [];
    final List<ArticleModel> articles = [];
    final configDir = Directory('${Directory.current.path}/config');
    final dirs = configDir
        .listSync()
        .skipWhile(
            (value) => path.basename(value.path).startsWith('.')) // 过滤隐藏文件
        .toList();
    dirs.sort(
        (a, b) => path.basename(a.path).compareTo(path.basename(b.path))); // 排序
    for (final FileSystemEntity file in dirs) {
      final String fileName = path.basename(file.path);
      final groupName = fileName.substring(fileName.indexOf('.') + 1);
      final iconAddress = 'assets/imgs/$groupName/icon.svg';
      final ArticleGroupModel group = ArticleGroupModel(
          name: groupName,
          iconAddress: iconAddress);
      groups.add(group);

      final markDownDirectory = Directory(file.path);
      final markDowns = markDownDirectory
          .listSync()
          .skipWhile(
              (value) => !path.basename(value.path).endsWith('.md')) // 过滤隐藏文件
          .toList();

      /// 创建文件夹
      final destMarkDownDirectory = Directory('$markDownsPath/${group.name}');
      if (!destMarkDownDirectory.existsSync()) destMarkDownDirectory.create();

      final destImgsnDirectory = Directory('$imgsPath/${group.name}');
      if (!destImgsnDirectory.existsSync()) destImgsnDirectory.create();

      /// 拷贝img
      File('${file.path}/icon.svg')
          .copySync(iconAddress);

      /// 遍历该目录下
      for (final FileSystemEntity markDown in markDowns) {
        final file = File(markDown.path);
        final contents = file.readAsStringSync().split('----------');
        final articleName = path
            .basename(markDown.path)
            .substring(0, path.basename(markDown.path).indexOf('.'));
        final articleAddress = '$markDownsPath/${group.name}/$articleName.md';
        final imageAddress = '$imgsPath/${group.name}/$articleName.svg';

        /// 拷贝markdown
        final article = File(articleAddress);
        article.create();
        article.writeAsString(contents.last.trim());

        /// 拷贝img
        File('${markDown.path.substring(0, markDown.path.lastIndexOf('.'))}.svg')
            .copySync(imageAddress);

        final model = ArticleModel(
          articleName: articleName,
          createTime: contents.first.trim(),
          lastModifiedTime: contents.first.trim(),
          tag: group.name,
          summary: getSummery(contents.last),
          imageAddress: '$imgsPath/${group.name}/$articleName.svg',
          articleAddress: '$markDownsPath/${group.name}/$articleName.md',
        );

        articles.add(model);
      }
    }

    final jsonList = articles.map((e) => e.toJson()).toList();
    File('${Directory.current.path}/assets/article.json').writeAsString(jsonEncode(jsonList));

    final groupList = groups.map((e) => e.toJson()).toList();
    File('${Directory.current.path}/assets/group.json').writeAsString(jsonEncode(groupList));

  });
}
