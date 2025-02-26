import 'package:flutter/widgets.dart';
import '../../../domain/models/mood/mood_data_model.dart';

class MoodContentEditViewModel extends ChangeNotifier {
  MoodContentEditViewModel({required MoodDataModel moodData}) : _moodData = moodData {}

  /// 当前心情详细数据
  MoodDataModel _moodData;
  MoodDataModel get moodData => _moodData;
  set moodData(MoodDataModel value) {
    _moodData = value;
    notifyListeners();
  }
}
