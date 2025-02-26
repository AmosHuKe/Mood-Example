// dart format width=60
import 'package:flutter/widgets.dart';

/// 心情类别
@immutable
class MoodCategoryModel {
  const MoodCategoryModel({
    required this.icon,
    required this.title,
  });

  factory MoodCategoryModel.fromJson(Map json) {
    return MoodCategoryModel(
      icon: json['icon'],
      title: json['title'],
    );
  }

  /// 表情
  final String icon;

  /// 表情标题
  final String title;

  Map<String, dynamic> toJson() {
    return {'icon': icon, 'title': title};
  }

  MoodCategoryModel copyWith({
    String? icon,
    String? title,
  }) {
    return MoodCategoryModel(
      icon: icon ?? this.icon,
      title: title ?? this.title,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MoodCategoryModel &&
          runtimeType == other.runtimeType &&
          icon == other.icon &&
          title == other.title;

  @override
  int get hashCode => Object.hashAll([icon, title]);
}
