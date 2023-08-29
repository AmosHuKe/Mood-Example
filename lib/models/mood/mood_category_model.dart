import 'dart:convert';
import 'package:flutter/widgets.dart';

MoodCategoryData moodCategoryDataFromJson(String str) =>
    MoodCategoryData.fromJson(json.decode(str));
String moodCategoryDataToJson(MoodCategoryData data) =>
    json.encode(data.toJson());

/// 心情类别数据
@immutable
class MoodCategoryData {
  const MoodCategoryData({
    required this.icon,
    required this.title,
  });

  factory MoodCategoryData.fromJson(Map<String, dynamic> json) =>
      MoodCategoryData(
        icon: json['icon'],
        title: json['title'],
      );

  // 表情
  final String icon;
  // 标题
  final String title;

  Map<String, dynamic> toJson() => {
        'icon': icon,
        'title': title,
      };
}
