

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:blog/main.dart';
import 'package:blog/model/model.dart';

void main() {

  test('生成配置', () {
    // 遍历文件夹，生成文章类型, 文章中的icon.svg, 为其图标
    print('${Directory.current}');
    List<ArticleGroupModel> groups = [];
    List<ArticleGroupModel> articles = [];
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
      for (final FileSystemEntity markDown in markDowns) {
        print(markDown.path);
      }
    }

//    for (final ArticleGroupModel group in groups) {
//      print('${group.name}');
//    }


    // 遍历文件夹里面的md，并设置好各种属性


  });

}