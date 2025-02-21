import 'package:flutter/widgets.dart';

/// 近日情绪波动数据
@immutable
class StatisticMoodScoreAverageRecentlyData {
  const StatisticMoodScoreAverageRecentlyData({
    required this.datetime,
    required this.score,
  });

  factory StatisticMoodScoreAverageRecentlyData.fromJson(Map json) {
    return StatisticMoodScoreAverageRecentlyData(
      datetime: json['datetime'],
      score: json['score'],
    );
  }

  final String datetime;
  final int score;

  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
      'score': score,
    };
  }

  StatisticMoodScoreAverageRecentlyData copyWith({
    String? datetime,
    int? score,
  }) {
    return StatisticMoodScoreAverageRecentlyData(
      datetime: datetime ?? this.datetime,
      score: score ?? this.score,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticMoodScoreAverageRecentlyData &&
          runtimeType == other.runtimeType &&
          datetime == other.datetime &&
          score == other.score;

  @override
  int get hashCode => Object.hashAll([
        datetime,
        score,
      ]);
}

// StatisticDateMoodCountData statisticDateMoodCountDataFromJson(String str) =>
//     StatisticDateMoodCountData.fromJson(json.decode(str));
// String statisticDateMoodCountDataToJson(StatisticDateMoodCountData data) =>
//     json.encode(data.toJson());

// /// 近日心情数量统计数据
// @immutable
// class StatisticDateMoodCountData {
//   const StatisticDateMoodCountData({required this.icon, required this.title, required this.count});

//   factory StatisticDateMoodCountData.fromJson(Map<String, dynamic> json) =>
//       StatisticDateMoodCountData(icon: json['icon'], title: json['title'], count: json['count']);

//   /// 图标
//   final String icon;

//   /// 心情（标题）
//   final String title;

//   /// 数量
//   final int count;

//   Map<String, dynamic> toJson() => {'icon': icon, 'title': title, 'count': count};
// }

/// 近日心情数量统计数据
@immutable
class StatisticDateMoodCountData {
  const StatisticDateMoodCountData({
    required this.icon,
    required this.title,
    required this.count,
  });

  factory StatisticDateMoodCountData.fromJson(Map json) {
    return StatisticDateMoodCountData(
      icon: json['icon'],
      title: json['title'],
      count: json['count'],
    );
  }

  final String icon;
  final String title;
  final int count;

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'title': title,
      'count': count,
    };
  }

  StatisticDateMoodCountData copyWith({
    String? icon,
    String? title,
    int? count,
  }) {
    return StatisticDateMoodCountData(
      icon: icon ?? this.icon,
      title: title ?? this.title,
      count: count ?? this.count,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticDateMoodCountData &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title &&
          count == other.count;

  @override
  int get hashCode => Object.hashAll([
        icon,
        title,
        count,
      ]);
}
