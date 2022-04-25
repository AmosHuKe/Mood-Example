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

  /// 心情数据
  late MoodData _moodData;

  /// 当前选择的日期
  DateTime _nowDateTime = DateTime.now();

  /// 心情数据加载
  bool _moodDataLoading = true;

  /// 所有已记录心情的日期
  List _moodRecordedDate = [];

  /// 心情类别详细
  late MoodCategoryData _moodCategoryData;

  /// 心情类别List
  List<MoodCategoryData>? _moodCategoryList = [];

  /// 所有心情数据List
  List<MoodData>? _moodAllDataList = [];

  /// 赋值心情数据
  void setMoodDataList(MoodModel moodModel) {
    _moodDataList = [];
    _moodDataList = moodModel.moodData;
    _moodDataLoading = false;
    notifyListeners();
  }

  /// 赋值心情数据加载
  setMoodDataLoading(bool moodDataLoading) {
    _moodDataLoading = moodDataLoading;
    notifyListeners();
  }

  /// 心情单个数据
  setMoodData(MoodData moodData) {
    _moodData = moodData;
  }

  /// 赋值当前选择的日期
  setNowDateTime(DateTime dateTime) {
    _nowDateTime = dateTime;
  }

  /// 赋值所有已记录心情的日期
  setMoodRecordedDate(List moodRecordedDate) {
    _moodRecordedDate = [];
    _moodRecordedDate = moodRecordedDate;
    notifyListeners();
  }

  /// 设置心情类别默认值
  Future<bool> setMoodCategoryDefault() async {
    bool initMoodCategoryDefaultType =
        await PreferencesDB().getInitMoodCategoryDefaultType();
    print("心情类别默认值初始化:" + initMoodCategoryDefaultType.toString());
    if (!initMoodCategoryDefaultType) {
      print("开始心情类别默认值初始化");
      MoodService.setCategoryDefault();

      /// 已赋值默认值标记
      await PreferencesDB().setInitMoodCategoryDefaultType(true);
    }
    return true;
  }

  /// 心情类别单个数据
  setMoodCategoryData(MoodCategoryData moodCategoryData) {
    _moodCategoryData = moodCategoryData;
  }

  /// 更新心情类别
  void setMoodCategory(MoodCategoryModel moodCategoryModel) {
    _moodCategoryList = [];
    _moodCategoryList = moodCategoryModel.moodCategoryData;
    notifyListeners();
  }

  /// 赋值所有心情数据
  void setMoodAllDataList(MoodModel moodModel) {
    _moodAllDataList = [];
    _moodAllDataList = moodModel.moodData;
    notifyListeners();
  }

  /// 心情数据
  List<MoodData>? get moodDataList => _moodDataList;
  MoodData? get moodData => _moodData;
  DateTime get nowDateTime => _nowDateTime;
  bool get moodDataLoading => _moodDataLoading;
  List get moodRecordedDate => _moodRecordedDate;
  MoodCategoryData get moodCategoryData => _moodCategoryData;
  List<MoodCategoryData>? get moodCategoryList => _moodCategoryList;
  List<MoodData>? get moodAllDataList => _moodAllDataList;
}
