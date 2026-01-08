import '../../../shared/utils/log_utils.dart';
import '../../../shared/utils/result.dart';
import '../../repositories/application/security_key_repository.dart';

class SecurityKeyUseCase {
  SecurityKeyUseCase({required SecurityKeyRepository securityKeyRepository})
    : _securityKeyRepository = securityKeyRepository;

  final SecurityKeyRepository _securityKeyRepository;

  /// 获取安全密码内容
  Future<Result<String>> getKeyPassword() async {
    final keyPasswordResult = await _securityKeyRepository.getKeyPassword();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, keyPasswordResult);
    }
    switch (keyPasswordResult) {
      case Success<String?>():
        return .success(keyPasswordResult.value ?? '');
      case Error<String?>():
        return .error(keyPasswordResult.error);
    }
  }

  /// 设置安全密码内容
  Future<Result<bool>> setKeyPassword(String keyPassword) async {
    final result = await _securityKeyRepository.setKeyPassword(keyPassword);
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<bool>():
        return .success(result.value);
      case Error<bool>():
        return .error(result.error);
    }
  }

  /// 获取是否开启安全生物特征识别
  Future<Result<bool>> getKeyBiometric() async {
    final keyBiometricResult = await _securityKeyRepository.getKeyBiometric();
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, keyBiometricResult);
    }
    switch (keyBiometricResult) {
      case Success<bool?>():
        final resultValue = keyBiometricResult.value ?? false;
        return .success(resultValue);
      case Error<bool?>():
        return .error(keyBiometricResult.error);
    }
  }

  /// 设置是否开启安全生物特征识别
  Future<Result<bool>> setKeyBiometric(bool keyBiometric) async {
    final result = await _securityKeyRepository.setKeyBiometric(keyBiometric);
    if (Log.isDebug) {
      Log.instance.resultStackTraceLog(StackTrace.current, result);
    }
    switch (result) {
      case Success<bool>():
        return .success(result.value);
      case Error<bool>():
        return .error(result.error);
    }
  }
}
