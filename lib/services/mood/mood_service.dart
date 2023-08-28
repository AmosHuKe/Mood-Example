import 'dart:convert';

///
import 'package:moodexample/db/db.dart';

///
import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/view_models/mood/mood_view_model.dart';

/// 心情相关
class MoodService {
  /// 设置心情类别默认值
  static Future<void> setCategoryDefault() async {
    /// 默认值
    final List<Map<String, String>> moodCategoryData = [
      {
        'icon': '😊',
        'title': '开心',
      },
      {
        'icon': '🎉',
        'title': '惊喜',
      },
      {
        'icon': '🤡',
        'title': '滑稽',
      },
      {
        'icon': '😅',
        'title': '尴尬',
      },
      {
        'icon': '😟',
        'title': '伤心',
      },
      {
        'icon': '🤯',
        'title': '惊讶',
      },
      {
        'icon': '🤩',
        'title': '崇拜',
      },
      {
        'icon': '😡',
        'title': '生气',
      }
    ];

    for (final value in moodCategoryData) {
      final MoodCategoryData moodCategoryData =
          moodCategoryDataFromJson(json.encode(value));
      DB.db.insertMoodCategoryDefault(moodCategoryData);
    }
  }

  /// 获取所有心情类别
  static Future<void> getMoodCategoryAll(MoodViewModel moodViewModel) async {
    final moodCategoryData = await DB.db.selectMoodCategoryAll();
    final Map<String, List> moodCategoryDataAll = {'data': moodCategoryData};
    // 转换模型
    final MoodCategoryModel moodCategoryModel =
        moodCategoryModelFromJson(json.encode(moodCategoryDataAll));
    // 更新数据
    moodViewModel.moodCategoryList = moodCategoryModel.moodCategoryData;
  }

  /// 添加心情详情数据
  static Future<bool> addMoodData(
    MoodData moodData,
  ) async {
    // 添加数据
    final bool result = await DB.db.insertMood(moodData);
    return result;
  }

  /// 获取详情数据
  static Future<void> getMoodData(
    MoodViewModel moodViewModel,
    String datetime,
  ) async {
    // 查询心情数据
    final moodData = await DB.db.selectMood(datetime);
    final Map<String, List> moodDataAll = {'data': moodData};
    // 转换模型
    final MoodModel moodModel = moodModelFromJson(json.encode(moodDataAll));
    // 更新数据
    moodViewModel.moodDataList = moodModel.moodData;
  }

  /// 获取所有已记录心情的日期
  static Future<void> getMoodRecordedDate(MoodViewModel moodViewModel) async {
    /// 数据
    late final List dataList = [];
    // 查询
    final list = await DB.db.selectMoodRecordedDate();
    for (int i = 0; i < list.length; i++) {
      late final String recordedDate = list[i]['recordedDate'] ?? '';
      late final String icon = list[i]['icon'] ?? '';

      dataList.add({'recordedDate': recordedDate, 'icon': icon});
    }
    print('已记录的日期$dataList');
    // 更新数据
    moodViewModel.moodRecordedDate = dataList;
  }

  /// 修改心情详细数据
  static Future<bool> editMood(
    MoodData moodData,
  ) async {
    // 修改数据
    final bool result = await DB.db.updateMood(moodData);
    return result;
  }

  /// 删除心情详细数据
  static Future<bool> delMood(
    MoodData moodData,
  ) async {
    // 删除数据
    final bool result = await DB.db.deleteMood(moodData);
    return result;
  }

  /// 获取所有心情详情数据
  static Future<void> getMoodAllData(MoodViewModel moodViewModel) async {
    // 查询心情数据
    final moodData = await DB.db.selectAllMood();
    final Map<String, List> moodDataAll = {'data': moodData};
    // 转换模型
    final MoodModel moodModel = moodModelFromJson(json.encode(moodDataAll));
    // 更新数据
    moodViewModel.moodAllDataList = moodModel.moodData;
  }
}
