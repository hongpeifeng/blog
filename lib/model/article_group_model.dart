

import 'package:json_annotation/json_annotation.dart';

part 'article_group_model.g.dart';

@JsonSerializable()
class ArticleGroupModel {

  final String name;
  final String iconAddress;

  ArticleGroupModel({
    required this.name,
    required this.iconAddress,
  });

  factory ArticleGroupModel.fromJson(Map<String, dynamic> json) => _$ArticleGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleGroupModelToJson(this);
}