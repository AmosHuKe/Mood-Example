import 'package:flutter/material.dart';

///
import 'package:moodexample/db/preferences_db.dart';

///
import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';

// 心情页相关
class MoodViewModel extends ChangeNotifier {
  /// 心情数据List
  List<MoodData>? _moodDataList = [];

  /// 当前选择的日期
  DateTime nowDateTime = DateTime.now();

  /// 心情数据加载
  bool _moodDataLoading = true;

  /// 所有已记录心情的日期
  List _moodRecordedDate = [];

  /// 心情类别List
  List<MoodCategoryData>? _moodCategoryList = [];

  /// 所有心情数据List
  List<MoodData>? _moodAllDataList = [];

  /// 赋值心情数据
  set moodDataList(List<MoodData>? moodData) {
    _moodDataList = [];
    _moodDataList = moodData;
    _moodDataLoading = false;
    notifyListeners();
  }

  /// 赋值心情数据加载
  set moodDataLoading(bool moodDataLoading) {
    _moodDataLoading = moodDataLoading;
    notifyListeners();
  }

  /// 赋值所有已记录心情的日期
  set moodRecordedDate(List moodRecordedDate) {
    _moodRecordedDate = [];
    _moodRecordedDate = moodRecordedDate;
    notifyListeners();
  }

  /// 设置心情类别默认值
  Future<bool> setMoodCategoryDefault() async {
    bool initMoodCategoryDefaultType =
        await PreferencesDB().getInitMoodCategoryDefaultType();
    debugPrint("心情类别默认值初始化:$initMoodCategoryDefaultType");
    if (!initMoodCategoryDefaultType) {
      debugPrint("开始心情类别默认值初始化");
      MoodService.setCategoryDefault();

      /// 已赋值默认值标记
      await PreferencesDB().setInitMoodCategoryDefaultType(true);
    }
    return true;
  }

  /// 更新心情类别
  set moodCategoryList(List<MoodCategoryData>? moodCategoryData) {
    _moodCategoryList = [];
    _moodCategoryList = moodCategoryData;
    notifyListeners();
  }

  /// 赋值所有心情数据
  set moodAllDataList(List<MoodData>? moodData) {
    _moodAllDataList = [];
    _moodAllDataList = moodData;
    notifyListeners();
  }

  /// 心情数据
  List<MoodData>? get moodDataList => _moodDataList;
  bool get moodDataLoading => _moodDataLoading;
  List get moodRecordedDate => _moodRecordedDate;
  List<MoodCategoryData>? get moodCategoryList => _moodCategoryList;
  List<MoodData>? get moodAllDataList => _moodAllDataList;
}
