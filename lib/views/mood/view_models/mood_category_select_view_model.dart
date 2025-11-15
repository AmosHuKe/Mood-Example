import 'package:flutter/widgets.dart';
import '../../../utils/utils.dart';
import '../../../utils/result.dart';
import '../../../domain/models/mood/mood_category_model.dart';
import '../../../domain/use_cases/mood/mood_category_load_use_case.dart';

/// 页面类型
enum MoodCategorySelectType {
  add,
  edit;

  static MoodCategorySelectType fromString(String type) =>
      values.firstWhere((e) => e.name == type, orElse: () => add);
}

class MoodCategorySelectViewModel extends ChangeNotifier {
  MoodCategorySelectViewModel({
    required MoodCategoryLoadUseCase moodCategoryLoadUseCase,
    required MoodCategorySelectType screenType,
    required DateTime selectDateTime,
  }) : _moodCategoryLoadUseCase = moodCategoryLoadUseCase,
       _screenType = screenType,
       _selectDateTime = selectDateTime {
    loadMoodCategoryAll();
  }

  final MoodCategoryLoadUseCase _moodCategoryLoadUseCase;

  /// 页面类型
  final MoodCategorySelectType _screenType;
  MoodCategorySelectType get screenType => _screenType;

  /// 当前选择的日期
  final DateTime _selectDateTime;
  DateTime get selectDateTime => _selectDateTime;
  String get selectDateTimeToString => Utils.datetimeFormatToString(_selectDateTime);

  /// 当前选择的心情类别
  MoodCategoryModel? _selectMoodCategory;
  MoodCategoryModel? get selectMoodCategory => _selectMoodCategory;
  set selectMoodCategory(MoodCategoryModel? value) {
    _selectMoodCategory = value;
    notifyListeners();
  }

  /// 获取所有心情类别 加载
  bool _loadMoodCategoryAllLoading = false;
  bool get loadMoodCategoryAllLoading => _loadMoodCategoryAllLoading;

  /// 所有心情类别
  List<MoodCategoryModel> _moodCategoryAll = [];
  List<MoodCategoryModel> get moodCategoryAll => _moodCategoryAll;

  /// 获取所有心情类别
  Future<Result<void>> loadMoodCategoryAll() async {
    _loadMoodCategoryAllLoading = true;
    notifyListeners();

    final loadUseCaseResult = await _moodCategoryLoadUseCase.execute();
    switch (loadUseCaseResult) {
      case Success<List<MoodCategoryModel>>():
        _moodCategoryAll = loadUseCaseResult.value;
        _loadMoodCategoryAllLoading = false;
        notifyListeners();
        return const .success(null);
      case Error<List<MoodCategoryModel>>():
        return .error(loadUseCaseResult.error);
    }
  }
}
