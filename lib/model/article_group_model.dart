
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_group_model.g.dart';

@JsonSerializable()
class ArticleGroupModel {

  final String name;
  final String iconAddress;

  ArticleGroupModel({
    @required this.name,
    @required this.iconAddress,
  });

  factory ArticleGroupModel.fromJson(Map<String, dynamic> json) => _$ArticleGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleGroupModelToJson(this);

  NavigationRailDestination toDestination() {
    return NavigationRailDestination(
        icon: SvgPicture.asset(iconAddress, color: Colors.grey, width: 32, height: 32,),
        selectedIcon: SvgPicture.asset(iconAddress, color: Colors.redAccent, width: 32, height: 32,),
        label: Text(name)
    );
  }

}