import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'main_local.dart' as local;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // shared_preferences 模拟器需要使用（防止异常）
  // 该操作会清空所有 SharedPreferences 值
  // SharedPreferences.setMockInitialValues({});

  local.main();

  /// 强制竖屏
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[.portraitUp, .portraitDown]);
}
