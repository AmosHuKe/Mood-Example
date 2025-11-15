import 'package:flutter/widgets.dart';
import '../../../utils/result.dart';
import '../../../domain/models/mood/mood_category_model.dart';
import '../../../domain/use_cases/mood/mood_category_load_use_case.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel({required MoodCategoryLoadUseCase moodCategoryLoadUseCase})
    : _moodCategoryLoadUseCase = moodCategoryLoadUseCase {
    loadMoodCategoryAll();
  }

  final MoodCategoryLoadUseCase _moodCategoryLoadUseCase;

  bool _loading = false;
  bool get loading => _loading;

  /// 所有心情类别
  List<MoodCategoryModel> _moodCategoryAll = [];
  List<MoodCategoryModel> get moodCategoryAll => _moodCategoryAll;

  /// 获取所有心情类别
  Future<Result<void>> loadMoodCategoryAll() async {
    _loading = true;
    notifyListeners();

    final loadUseCaseResult = await _moodCategoryLoadUseCase.execute();
    switch (loadUseCaseResult) {
      case Success<List<MoodCategoryModel>>():
        _moodCategoryAll = loadUseCaseResult.value;
        _loading = false;
        notifyListeners();
        return const .success(null);
      case Error<List<MoodCategoryModel>>():
        return .error(loadUseCaseResult.error);
    }
  }
}
