import 'package:flutter/widgets.dart';
import '../../utils/utils.dart';
import '../../utils/result.dart';
import '../../domain/models/mood/mood_data_model.dart';
import '../../domain/use_cases/mood/mood_data_use_case.dart';

class MoodViewModel extends ChangeNotifier {
  MoodViewModel({required MoodDataUseCase moodDataUseCase}) : _moodDataUseCase = moodDataUseCase {
    load();
  }

  final MoodDataUseCase _moodDataUseCase;

  /// 当前选择的日期
  DateTime _selectDateTime = .now();
  DateTime get selectDateTime => _selectDateTime;
  String get selectDateTimeToString => Utils.datetimeFormatToString(_selectDateTime);
  set selectDateTime(DateTime value) {
    _selectDateTime = value;
    notifyListeners();
  }

  /// 心情数据加载
  bool _moodDataListLoading = false;
  bool get moodDataListLoading => _moodDataListLoading;

  /// 所选日期心情数据
  List<MoodDataModel> _moodDataList = [];
  List<MoodDataModel> get moodDataList => _moodDataList;

  /// 所有心情的记录日期数据
  List<MoodRecordDateModel> _moodRecordDateAllList = [];
  List<MoodRecordDateModel> get moodRecordDateAllList => _moodRecordDateAllList;

  /// 加载所有
  Future<void> load() async {
    await loadMoodDataList();
    await loadMoodRecordDateAllList();
  }

  /// 根据日期获取心情详细数据
  Future<Result<void>> loadMoodDataList() async {
    _moodDataListLoading = true;
    notifyListeners();
    final moodDataListResult = await _moodDataUseCase.getMoodDataByDateTime(_selectDateTime);
    switch (moodDataListResult) {
      case Success<List<MoodDataModel>>():
        _moodDataList = moodDataListResult.value;
        _moodDataListLoading = false;
        notifyListeners();
        return const .success(null);
      case Error<List<MoodDataModel>>():
        return .error(moodDataListResult.error);
    }
  }

  /// 添加心情详细数据
  Future<Result<bool>> addMoodData(MoodDataModel moodData) async {
    final result = await _moodDataUseCase.addMoodData(moodData);
    switch (result) {
      case Success<bool>():
        if (result.value) {
          load();
        }
        return result;
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 修改心情详细数据
  Future<Result<bool>> editMoodData(MoodDataModel moodData) async {
    final result = await _moodDataUseCase.editMoodData(moodData);
    switch (result) {
      case Success<bool>():
        if (result.value) {
          load();
        }
        return result;
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 删除心情详细数据
  ///
  /// - [moodId] 心情 ID
  Future<Result<bool>> deleteMoodData(int moodId) async {
    final result = await _moodDataUseCase.deleteMoodData(moodId);
    switch (result) {
      case Success<bool>():
        if (result.value) {
          load();
        }
        return result;
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 获取所有心情数据的记录日期数据
  Future<Result<void>> loadMoodRecordDateAllList() async {
    final moodRecordDateListResult = await _moodDataUseCase.getMoodRecordDateAll();
    switch (moodRecordDateListResult) {
      case Success<List<MoodRecordDateModel>>():
        _moodRecordDateAllList = moodRecordDateListResult.value;
        notifyListeners();
        return const .success(null);
      case Error<List<MoodRecordDateModel>>():
        return .error(moodRecordDateListResult.error);
    }
  }
}
