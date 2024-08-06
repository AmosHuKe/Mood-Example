import 'dart:convert';

import 'package:moodexample/db/db.dart';

import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/models/mood/mood_category_model.dart';

/// 心情相关
class MoodService {
  /// 设置心情类别默认值
  static Future<void> setCategoryDefault() async {
    /// 默认值
    const List<MoodCategoryData> moodCategoryData = [
      MoodCategoryData(icon: '😊', title: '开心'),
      MoodCategoryData(icon: '🎉', title: '惊喜'),
      MoodCategoryData(icon: '🤡', title: '滑稽'),
      MoodCategoryData(icon: '😅', title: '尴尬'),
      MoodCategoryData(icon: '😟', title: '伤心'),
      MoodCategoryData(icon: '🤯', title: '惊讶'),
      MoodCategoryData(icon: '🤩', title: '崇拜'),
      MoodCategoryData(icon: '😡', title: '生气'),
    ];

    for (final value in moodCategoryData) {
      DB.instance.insertMoodCategoryDefault(value);
    }
  }

  /// 获取所有心情类别
  static Future<List<MoodCategoryData>> getMoodCategoryAll() async {
    final moodCategoryData = await DB.instance.selectMoodCategoryAll();
    final List<MoodCategoryData> moodCategoryDataList = [];
    // 转换模型
    for (final value in moodCategoryData) {
      moodCategoryDataList.add(moodCategoryDataFromJson(json.encode(value)));
    }
    return moodCategoryDataList;
  }

  /// 添加心情详情数据
  static Future<bool> addMoodData(MoodData moodData) async {
    // 添加数据
    final bool result = await DB.instance.insertMood(moodData);
    return result;
  }

  /// 根据日期获取详情数据
  static Future<List<MoodData>> getMoodData(String datetime) async {
    // 查询心情数据
    final moodData = await DB.instance.selectMood(datetime);
    final List<MoodData> MoodDataList = [];
    for (final value in moodData) {
      // 转换模型
      MoodDataList.add(moodDataFromJson(json.encode(value)));
    }
    return MoodDataList;
  }

  /// 获取所有已记录心情的日期
  static Future<List<MoodRecordData>> getMoodRecordDate() async {
    // 查询
    final list = await DB.instance.selectMoodRecordDate();
    late final List<MoodRecordData> dataList = [];
    for (final value in list) {
      // 转换模型
      dataList.add(moodRecordDataFromJson(json.encode(value)));
    }
    return dataList;
  }

  /// 修改心情详细数据
  static Future<bool> editMood(MoodData moodData) async {
    // 修改数据
    final bool result = await DB.instance.updateMood(moodData);
    return result;
  }

  /// 删除心情详细数据
  static Future<bool> delMood(MoodData moodData) async {
    // 删除数据
    final bool result = await DB.instance.deleteMood(moodData);
    return result;
  }

  /// 获取所有心情详情数据
  static Future<List<MoodData>> getMoodAllData() async {
    // 查询心情数据
    final moodData = await DB.instance.selectAllMood();
    final List<MoodData> moodDataList = [];
    for (final value in moodData) {
      // 转换模型
      moodDataList.add(moodDataFromJson(json.encode(value)));
    }
    return moodDataList;
  }
}
