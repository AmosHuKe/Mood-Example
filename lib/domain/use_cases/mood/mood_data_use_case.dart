import 'dart:convert';
import '../../../utils/log_utils.dart';
import '../../../utils/result.dart';
import '../../models/mood/mood_data_model.dart';
import '../../repositories/mood/mood_data_repository.dart';

class MoodDataUseCase {
  MoodDataUseCase({required MoodDataRepository moodDataRepository})
    : _moodDataRepository = moodDataRepository;

  final MoodDataRepository _moodDataRepository;

  /// 获取心情数据
  ///
  /// - [dateTime] 当前选择的日期
  Future<Result<List<MoodDataModel>>> getMoodDataByDateTime(DateTime dateTime) async {
    final result = await _moodDataRepository.getMoodDataByDateTime(dateTime);
    switch (result) {
      case Success<List<MoodDataModel>>():
        LogUtils.stackTraceLog(
          StackTrace.current,
          result: result,
          message: jsonEncode(result.value),
        );
        return .success(result.value);
      case Error<List<MoodDataModel>>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }

  /// 获取所有心情数据的记录日期数据
  Future<Result<List<MoodRecordDateModel>>> getMoodRecordDateAll() async {
    final result = await _moodDataRepository.getMoodRecordDateAll();
    switch (result) {
      case Success<List<MoodRecordDateModel>>():
        LogUtils.stackTraceLog(
          StackTrace.current,
          result: result,
          message: jsonEncode(result.value),
        );
        return .success(result.value);
      case Error<List<MoodRecordDateModel>>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }

  /// 添加心情详细数据
  Future<Result<bool>> addMoodData(MoodDataModel moodData) async {
    if (moodData.mood_id != null) return .error(Exception('MoodDataModel.mood_id 必须为空'));
    final result = await _moodDataRepository.addMoodData(moodData);
    switch (result) {
      case Success<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result, message: jsonEncode(moodData));
        return .success(result.value);
      case Error<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }

  /// 修改心情详细数据
  Future<Result<bool>> editMoodData(MoodDataModel moodData) async {
    if (moodData.mood_id == null) return .error(Exception('MoodDataModel.mood_id 不能为空'));
    final result = await _moodDataRepository.editMoodData(moodData);
    switch (result) {
      case Success<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result, message: jsonEncode(moodData));
        return .success(result.value);
      case Error<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }

  /// 删除心情详细数据
  ///
  /// - [moodId] 心情 ID
  Future<Result<bool>> deleteMoodData(int moodId) async {
    final result = await _moodDataRepository.deleteMoodData(moodId);
    switch (result) {
      case Success<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result, message: moodId.toString());
        return .success(result.value);
      case Error<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }
}
