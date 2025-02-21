import 'package:flutter/widgets.dart';

/// 心情类别数据
@immutable
class MoodCategoryData {
  const MoodCategoryData({
    required this.icon,
    required this.title,
  });

  factory MoodCategoryData.fromJson(Map json) {
    return MoodCategoryData(
      icon: json['icon'],
      title: json['title'],
    );
  }

  /// 表情
  final String icon;

  /// 标题
  final String title;

  Map<String, dynamic> toJson() {
    return {
      'icon': icon,
      'title': title,
    };
  }

  MoodCategoryData copyWith({
    String? icon,
    String? title,
  }) {
    return MoodCategoryData(
      icon: icon ?? this.icon,
      title: title ?? this.title,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodCategoryData &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title;

  @override
  int get hashCode => Object.hashAll([
        icon,
        title,
      ]);
}
