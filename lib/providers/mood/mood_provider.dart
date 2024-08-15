import 'package:flutter/material.dart';

import 'package:moodexample/db/preferences_db.dart';

import 'package:moodexample/models/mood/mood_model.dart';
import 'package:moodexample/models/mood/mood_category_model.dart';
import 'package:moodexample/services/mood/mood_service.dart';

// 心情页相关
class MoodProvider extends ChangeNotifier {
  MoodProvider() {
    load();
  }

  /// 心情数据List
  List<MoodData> _moodDataList = [];

  /// 当前选择的日期
  DateTime _nowDateTime = DateTime.now();

  /// 心情数据加载
  bool _moodDataLoading = false;

  /// 所有已记录心情的日期
  List<MoodRecordData> _moodRecordDate = [];

  /// 心情类别List
  List<MoodCategoryData> _moodCategoryList = [];

  /// 所有心情数据List
  List<MoodData>? _moodAllDataList = [];

  Future<void> load() async {
    await loadMoodCategoryAllList();
    await loadMoodRecordDateAllList();
    await loadMoodDataList();
  }

  /// 设置心情类别默认值
  Future<bool> _setMoodCategoryDefault() async {
    final bool initMoodCategoryDefaultType =
        await PreferencesDB.instance.getInitMoodCategoryDefaultType();
    print('心情类别默认值初始化:$initMoodCategoryDefaultType');
    if (!initMoodCategoryDefaultType) {
      print('开始心情类别默认值初始化');
      MoodService.setCategoryDefault();

      /// 已赋值默认值标记
      await PreferencesDB.instance.setInitMoodCategoryDefaultType(true);
    }
    return true;
  }

  /// 获取所有心情类别数据列表
  Future<void> loadMoodCategoryAllList() async {
    /// 设置心情类别默认值
    final bool setMoodCategoryDefaultresult = await _setMoodCategoryDefault();
    if (setMoodCategoryDefaultresult) {
      /// 获取所有心情类别
      moodCategoryList = await MoodService.getMoodCategoryAll();
    }
  }

  /// 根据日期获取详细数据列表
  Future<void> loadMoodDataList() async {
    _moodDataLoading = true;
    notifyListeners();
    moodDataList = await MoodService.getMoodData(
      _nowDateTime.toString().substring(0, 10),
    );
  }

  /// 所有心情详细数据列表
  Future<void> loadMoodDataAllList() async {
    moodAllDataList = await MoodService.getMoodAllData();
  }

  /// 获取所有记录心情的日期
  Future<void> loadMoodRecordDateAllList() async {
    moodRecordDate = await MoodService.getMoodRecordDate();
  }

  /// 添加心情详细数据
  Future<bool> addMoodData(MoodData moodData) async {
    return MoodService.addMoodData(moodData);
  }

  /// 修改心情详细数据
  Future<bool> editMoodData(MoodData moodData) async {
    return MoodService.editMood(moodData);
  }

  /// 删除心情详细数据
  Future<bool> deleteMoodData(MoodData moodData) async {
    return MoodService.delMood(moodData);
  }

  /// 赋值心情数据列表
  set moodDataList(List<MoodData> moodData) {
    _moodDataList = moodData;
    _moodDataLoading = false;
    notifyListeners();
  }

  /// 赋值当前选择得日期
  set nowDateTime(DateTime nowDateTime) {
    _nowDateTime = nowDateTime;
    notifyListeners();
  }

  /// 赋值心情数据加载
  set moodDataLoading(bool moodDataLoading) {
    _moodDataLoading = moodDataLoading;
    notifyListeners();
  }

  /// 赋值所有记录心情的日期
  set moodRecordDate(List<MoodRecordData> moodRecordDate) {
    _moodRecordDate = moodRecordDate;
    notifyListeners();
  }

  /// 更新心情类别
  set moodCategoryList(List<MoodCategoryData> moodCategoryData) {
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
  List<MoodData> get moodDataList => _moodDataList;
  DateTime get nowDateTime => _nowDateTime;
  bool get moodDataLoading => _moodDataLoading;
  List<MoodRecordData> get moodRecordDate => _moodRecordDate;
  List<MoodCategoryData> get moodCategoryList => _moodCategoryList;
  List<MoodData>? get moodAllDataList => _moodAllDataList;
}
