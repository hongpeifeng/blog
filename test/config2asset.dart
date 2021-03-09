

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:blog/main.dart';
import 'package:blog/model/model.dart';

void main() {

  final imgsPath = 'assets/imgs';
  final markDownsPath = 'assets/markdowns';


  String getSummery(String article) {
    return '';
  }

  test('生成配置', () {
    // 遍历文件夹，生成文章类型, 文章中的icon.svg, 为其图标
    print('${Directory.current}');
    List<ArticleGroupModel> groups = [];
    List<ArticleModel> articles = [];
    final configDir = Directory('${Directory.current.path}/config');
    final dirs = configDir.listSync()
        .skipWhile((value) => path.basename(value.path).startsWith('.')) // 过滤隐藏文件
        .toList();
    dirs.sort((a, b) => path.basename(a.path).compareTo(path.basename(b.path))); // 排序
    for (final FileSystemEntity file in dirs) {
      final String fileName = path.basename(file.path);
      final ArticleGroupModel group = ArticleGroupModel(
          name: fileName.substring(fileName.indexOf('.') + 1),
          iconAddress: '${file.path}/icon.svg');
      groups.add(group);

      final markDownDirectory = Directory(file.path);
      final markDowns = markDownDirectory.listSync()
          .skipWhile((value) => !path.basename(value.path).endsWith('.md')) // 过滤隐藏文件
          .toList();

      /// 创建文件夹
      final destMarkDownDirectory = Directory('$markDownsPath/${group.name}');
      if (!destMarkDownDirectory.existsSync())
        destMarkDownDirectory.create();

      /// 遍历该目录下
      for (final FileSystemEntity markDown in markDowns) {

        final file = File(markDown.path);
        final contents = file.readAsStringSync().split('----------');
        final articleName = path.basename(markDown.path).substring(0, path.basename(markDown.path).indexOf('.'));
        final articleAddress = '$markDownsPath/${group.name}/$articleName.md';

        /// 拷贝markdown
        final article = File(articleAddress);
        article.create();
        article.writeAsString(contents.last.trim());

        /// 拷贝img
        final imgfile = File('${markDown.path.substring(0, markDown.path.indexOf('.'))}');

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

//    for (final ArticleGroupModel group in groups) {
//      print('${group.name}');
//    }


    // 遍历文件夹里面的md，并设置好各种属性


  });

}