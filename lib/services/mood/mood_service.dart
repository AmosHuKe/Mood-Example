import 'dart:convert';
import 'package:flutter/material.dart';

///
import 'package:moodexample/db/db.dart';

///
import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/view_models/mood/mood_view_model.dart';

class MoodService {
  /// 设置心情类别默认值
  static Future<void> setCategoryDefault() async {
    /// 默认值
    List<Map<String, String>> moodCategoryData = [
      {
        "icon": "😊",
        "title": "开心",
      },
      {
        "icon": "🎉",
        "title": "惊喜",
      },
      {
        "icon": "🤡",
        "title": "滑稽",
      },
      {
        "icon": "😅",
        "title": "尴尬",
      },
      {
        "icon": "😟",
        "title": "伤心",
      },
      {
        "icon": "🤯",
        "title": "惊讶",
      },
      {
        "icon": "🤩",
        "title": "崇拜",
      },
      {
        "icon": "😡",
        "title": "生气",
      }
    ];

    for (var value in moodCategoryData) {
      MoodCategoryData moodCategoryData =
          moodCategoryDataFromJson(json.encode(value));
      DB.db.insertMoodCategoryDefault(moodCategoryData);
    }
  }

  /// 获取所有心情类别
  static Future<void> getMoodCategoryAll(MoodViewModel moodViewModel) async {
    final moodCategoryData = await DB.db.selectMoodCategoryAll();
    Map<String, List> moodCategoryDataAll = {"data": moodCategoryData};
    // 转换模型
    MoodCategoryModel moodCategoryModel =
        moodCategoryModelFromJson(json.encode(moodCategoryDataAll));
    // 更新数据
    moodViewModel.setMoodCategory(moodCategoryModel);
  }

  /// 添加心情详情数据
  static Future<bool> addMoodData(
    MoodData moodData,
  ) async {
    // 添加数据
    bool result = await DB.db.insertMood(moodData);
    return result;
  }

  /// 获取详情数据
  static Future<void> getMoodData(
      MoodViewModel moodViewModel, String datetime) async {
    // 查询心情数据
    final moodData = await DB.db.selectMood(datetime);
    Map<String, List> moodDataAll = {"data": moodData};
    // 转换模型
    MoodModel moodModel = moodModelFromJson(json.encode(moodDataAll));
    // 更新数据
    moodViewModel.setMoodDataList(moodModel);
  }

  /// 获取所有已记录心情的日期
  static Future<void> getMoodRecordedDate(MoodViewModel moodViewModel) async {
    /// 数据
    late List dataList = [];
    // 查询
    final list = await DB.db.selectMoodRecordedDate();
    for (int i = 0; i < list.length; i++) {
      late String recordedDate = list[i]["recordedDate"] ?? "";
      late String icon = list[i]["icon"] ?? "";

      dataList.add({"recordedDate": recordedDate, "icon": icon});
    }
    debugPrint("已记录的日期$dataList");
    // 更新数据
    moodViewModel.setMoodRecordedDate(dataList);
  }

  /// 修改心情详细数据
  static Future<bool> editMood(
    MoodData moodData,
  ) async {
    // 修改数据
    bool result = await DB.db.updateMood(moodData);
    return result;
  }

  /// 删除心情详细数据
  static Future<bool> delMood(
    MoodData moodData,
  ) async {
    // 删除数据
    bool result = await DB.db.deleteMood(moodData);
    return result;
  }

  /// 获取所有心情详情数据
  static Future<void> getMoodAllData(MoodViewModel moodViewModel) async {
    // 查询心情数据
    final moodData = await DB.db.selectAllMood();
    Map<String, List> moodDataAll = {"data": moodData};
    // 转换模型
    MoodModel moodModel = moodModelFromJson(json.encode(moodDataAll));
    // 更新数据
    moodViewModel.setMoodAllDataList(moodModel);
  }
}
