// dart format width=60
import 'package:flutter/widgets.dart';

/// 近日情绪波动数据
@immutable
class StatisticMoodScoreAverageRecentlyModel {
  const StatisticMoodScoreAverageRecentlyModel({
    required this.datetime,
    required this.score,
  });

  factory StatisticMoodScoreAverageRecentlyModel.fromJson(
    Map json,
  ) {
    return StatisticMoodScoreAverageRecentlyModel(
      datetime: json['datetime'],
      score: json['score'],
    );
  }

  final String datetime;
  final int score;

  Map<String, dynamic> toJson() {
    return {'datetime': datetime, 'score': score};
  }

  StatisticMoodScoreAverageRecentlyModel copyWith({
    String? datetime,
    int? score,
  }) {
    return StatisticMoodScoreAverageRecentlyModel(
      datetime: datetime ?? this.datetime,
      score: score ?? this.score,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticMoodScoreAverageRecentlyModel &&
          runtimeType == other.runtimeType &&
          datetime == other.datetime &&
          score == other.score;

  @override
  int get hashCode => Object.hashAll([datetime, score]);
}

/// 近日心情数量统计数据
@immutable
class StatisticMoodCountRecentlyModel {
  const StatisticMoodCountRecentlyModel({
    required this.icon,
    required this.title,
    required this.count,
  });

  factory StatisticMoodCountRecentlyModel.fromJson(
    Map json,
  ) {
    return StatisticMoodCountRecentlyModel(
      icon: json['icon'],
      title: json['title'],
      count: json['count'],
    );
  }

  final String icon;
  final String title;
  final int count;

  Map<String, dynamic> toJson() {
    return {'icon': icon, 'title': title, 'count': count};
  }

  StatisticMoodCountRecentlyModel copyWith({
    String? icon,
    String? title,
    int? count,
  }) {
    return StatisticMoodCountRecentlyModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      count: count ?? this.count,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticMoodCountRecentlyModel &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title &&
          count == other.count;

  @override
  int get hashCode => Object.hashAll([icon, title, count]);
}
