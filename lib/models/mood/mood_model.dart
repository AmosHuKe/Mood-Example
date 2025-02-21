// dart format width=60
import 'package:flutter/widgets.dart';

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

  factory MoodData.fromJson(Map json) {
    return MoodData(
      mood_id: json['mood_id'],
      icon: json['icon'],
      title: json['title'],
      score: json['score'],
      content: json['content'],
      create_time: json['create_time'],
      update_time: json['update_time'],
    );
  }

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

  Map<String, dynamic> toJson() {
    return {
      'mood_id': mood_id,
      'icon': icon,
      'title': title,
      'score': score,
      'content': content,
      'create_time': create_time,
      'update_time': update_time,
    };
  }

  MoodData copyWith({
    int? mood_id,
    String? icon,
    String? title,
    int? score,
    String? content,
    String? create_time,
    String? update_time,
  }) {
    return MoodData(
      mood_id: mood_id ?? this.mood_id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      score: score ?? this.score,
      content: content ?? this.content,
      create_time: create_time ?? this.create_time,
      update_time: update_time ?? this.update_time,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodData &&
          runtimeType == other.runtimeType &&
          mood_id == other.mood_id &&
          icon == other.icon &&
          title == other.title &&
          score == other.score &&
          content == other.content &&
          create_time == other.create_time &&
          update_time == other.update_time;

  @override
  int get hashCode => Object.hashAll([
    mood_id,
    icon,
    title,
    score,
    content,
    create_time,
    update_time,
  ]);
}

/// 心情记录日期数据
@immutable
class MoodRecordData {
  const MoodRecordData({
    required this.record_date,
    required this.icon,
  });

  factory MoodRecordData.fromJson(Map json) {
    return MoodRecordData(
      record_date: json['record_date'],
      icon: json['icon'],
    );
  }

  /// 记录日期
  final String record_date;

  /// 图标
  final String icon;

  Map<String, dynamic> toJson() {
    return {'record_date': record_date, 'icon': icon};
  }

  MoodRecordData copyWith({
    String? recordDate,
    String? icon,
  }) {
    return MoodRecordData(
      record_date: recordDate ?? this.record_date,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodRecordData &&
          runtimeType == other.runtimeType &&
          record_date == other.record_date &&
          icon == other.icon;

  @override
  int get hashCode => Object.hashAll([record_date, icon]);
}
