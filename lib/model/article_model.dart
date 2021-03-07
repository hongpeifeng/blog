
import 'package:json_annotation/json_annotation.dart';

part 'article_model.g.dart';

@JsonSerializable()
class ArticleModel {
  ///文章标题
  String articleName;

  ///创建日期
  String createTime;

  ///修改日期
  String lastModifiedTime;

  ///标签
  String tag;

  ///摘要
  String summary;

  ///图片地址
  String imageAddress;

  ///文章地址
  String articleAddress;

  ArticleModel({
    required this.articleName,
    required this.createTime,
    required this.lastModifiedTime,
    required this.tag,
    required this.summary,
    required this.imageAddress,
    required this.articleAddress,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => _$ArticleModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleModelToJson(this);
}