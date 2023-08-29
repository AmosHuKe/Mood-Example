import 'dart:convert';
import 'package:flutter/widgets.dart';

StatisticMoodScoreAverageRecentlyData
    statisticMoodScoreAverageRecentlyDataFromJson(String str) =>
        StatisticMoodScoreAverageRecentlyData.fromJson(json.decode(str));
String statisticMoodScoreAverageRecentlyDataToJson(
  StatisticMoodScoreAverageRecentlyData data,
) =>
    json.encode(data.toJson());

/// 近日情绪波动数据
@immutable
class StatisticMoodScoreAverageRecentlyData {
  const StatisticMoodScoreAverageRecentlyData({
    required this.datetime,
    required this.score,
  });

  factory StatisticMoodScoreAverageRecentlyData.fromJson(
    Map<String, dynamic> json,
  ) =>
      StatisticMoodScoreAverageRecentlyData(
        datetime: json['datetime'],
        score: json['score'],
      );

  // 记录日期
  final String datetime;
  // 分数
  final int score;

  Map<String, dynamic> toJson() => {
        'datetime': datetime,
        'score': score,
      };
}

StatisticDateMoodCountData statisticDateMoodCountDataFromJson(String str) =>
    StatisticDateMoodCountData.fromJson(json.decode(str));
String statisticDateMoodCountDataToJson(StatisticDateMoodCountData data) =>
    json.encode(data.toJson());

/// 近日心情数量统计数据
@immutable
class StatisticDateMoodCountData {
  const StatisticDateMoodCountData({
    required this.icon,
    required this.title,
    required this.count,
  });

  factory StatisticDateMoodCountData.fromJson(
    Map<String, dynamic> json,
  ) =>
      StatisticDateMoodCountData(
        icon: json['icon'],
        title: json['title'],
        count: json['count'],
      );

  // 图标
  final String icon;
  // 心情（标题）
  final String title;
  // 数量
  final int count;

  Map<String, dynamic> toJson() => {
        'icon': icon,
        'title': title,
        'count': count,
      };
}
