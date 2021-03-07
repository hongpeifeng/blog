// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleModel _$ArticleModelFromJson(Map<String, dynamic> json) {
  return ArticleModel(
    articleName: json['articleName'] as String,
    createTime: json['createTime'] as String,
    lastModifiedTime: json['lastModifiedTime'] as String,
    tag: json['tag'] as String,
    summary: json['summary'] as String,
    imageAddress: json['imageAddress'] as String,
    articleAddress: json['articleAddress'] as String,
  );
}

Map<String, dynamic> _$ArticleModelToJson(ArticleModel instance) =>
    <String, dynamic>{
      'articleName': instance.articleName,
      'createTime': instance.createTime,
      'lastModifiedTime': instance.lastModifiedTime,
      'tag': instance.tag,
      'summary': instance.summary,
      'imageAddress': instance.imageAddress,
      'articleAddress': instance.articleAddress,
    };
