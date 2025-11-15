import 'package:flutter/widgets.dart';
import '../../utils/result.dart';
import '../../domain/use_cases/application/security_key_use_case.dart';
import '../../widgets/lock_screen/lock_screen.dart';

/// 安全密钥相关
class SecurityKeyViewModel extends ChangeNotifier {
  SecurityKeyViewModel({required SecurityKeyUseCase securityKeyUseCase})
    : _securityKeyUseCase = securityKeyUseCase {
    loadKeyPassword();
    loadKeyBiometric();
  }

  final SecurityKeyUseCase _securityKeyUseCase;

  /// 安全密码内容
  String _keyPassword = '';
  String get keyPassword => _keyPassword;
  set keyPassword(String value) {
    _securityKeyUseCase.setKeyPassword(value);
    _keyPassword = value;
    notifyListeners();
  }

  /// 是否开启安全生物特征识别
  bool _keyBiometric = false;
  bool get keyBiometric => _keyBiometric;
  set keyBiometric(bool value) {
    _securityKeyUseCase.setKeyBiometric(value);
    _keyBiometric = value;
    notifyListeners();
  }

  /// 是否打开安全密码界面
  bool _keyPasswordScreenOpen = false;
  bool get keyPasswordScreenOpen => _keyPasswordScreenOpen;
  set keyPasswordScreenOpen(bool value) {
    _keyPasswordScreenOpen = value;
  }

  /// 获取安全密码内容
  Future<Result<void>> loadKeyPassword() async {
    final result = await _securityKeyUseCase.getKeyPassword();
    switch (result) {
      case Success<String>():
        _keyPassword = result.value;
        notifyListeners();
        return const .success(null);
      case Error<String>():
        return .error(result.error);
    }
  }

  /// 获取是否开启安全生物特征识别
  Future<Result<void>> loadKeyBiometric() async {
    final result = await _securityKeyUseCase.getKeyBiometric();
    switch (result) {
      case Success<bool>():
        _keyBiometric = result.value;
        notifyListeners();
        return const .success(null);
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 加载锁屏界面
  Future<void> loadlockScreen(BuildContext context) async {
    if (_keyPasswordScreenOpen) return;
    WidgetsBinding.instance.endOfFrame.then((_) async {
      if (context.mounted) {
        await lockScreen(context, keyPassword: _keyPassword, keyBiometric: _keyBiometric);
      }
    });
  }
}
