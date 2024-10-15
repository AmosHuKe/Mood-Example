import 'dart:convert';
import 'package:flutter/widgets.dart';

MoodData moodDataFromJson(String str) => MoodData.fromJson(json.decode(str));
String moodDataToJson(MoodData data) => json.encode(data.toJson());

/// 心情详细数据
class MoodData {
  MoodData({
    this.mood_id,
    required this.icon,
    required this.title,
    this.score,
    this.content,
    required this.create_time,
    required this.update_time,
  });

  factory MoodData.fromJson(Map<String, dynamic> json) => MoodData(
        mood_id: json['mood_id'],
        icon: json['icon'],
        title: json['title'],
        score: json['score'],
        content: json['content'],
        create_time: json['create_time'],
        update_time: json['update_time'],
      );

  /// ID
  int? mood_id;

  /// 图标
  String icon;

  /// 标题（当前的心情）
  String title;

  /// 分数
  int? score;

  /// 内容
  String? content;

  /// 创建日期
  String create_time;

  /// 修改日期
  String update_time;

  Map<String, dynamic> toJson() => {
        'mood_id': mood_id,
        'icon': icon,
        'title': title,
        'score': score,
        'content': content,
        'create_time': create_time,
        'update_time': update_time,
      };
}

MoodRecordData moodRecordDataFromJson(String str) =>
    MoodRecordData.fromJson(json.decode(str));
String moodRecordDataToJson(MoodRecordData data) => json.encode(data.toJson());

/// 心情记录日期数据
@immutable
class MoodRecordData {
  const MoodRecordData({
    required this.record_date,
    required this.icon,
  });

  factory MoodRecordData.fromJson(Map<String, dynamic> json) => MoodRecordData(
        record_date: json['record_date'],
        icon: json['icon'],
      );

  /// 记录日期
  final String record_date;

  /// 图标
  final String icon;

  Map<String, dynamic> toJson() => {
        'record_date': record_date,
        'icon': icon,
      };
}
