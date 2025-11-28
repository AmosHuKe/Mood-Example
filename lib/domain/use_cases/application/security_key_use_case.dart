import '../../../utils/log_utils.dart';
import '../../../utils/result.dart';
import '../../repositories/application/security_key_repository.dart';

class SecurityKeyUseCase {
  SecurityKeyUseCase({required SecurityKeyRepository securityKeyRepository})
    : _securityKeyRepository = securityKeyRepository;

  final SecurityKeyRepository _securityKeyRepository;

  /// 获取安全密码内容
  Future<Result<String>> getKeyPassword() async {
    final keyPasswordResult = await _securityKeyRepository.getKeyPassword();
    switch (keyPasswordResult) {
      case Success<String?>():
        LogUtils.stackTraceLog(StackTrace.current, result: keyPasswordResult);
        return .success(keyPasswordResult.value ?? '');
      case Error<String?>():
        LogUtils.stackTraceLog(StackTrace.current, result: keyPasswordResult);
        return .error(keyPasswordResult.error);
    }
  }

  /// 设置安全密码内容
  Future<Result<bool>> setKeyPassword(String keyPassword) async {
    final result = await _securityKeyRepository.setKeyPassword(keyPassword);
    switch (result) {
      case Success<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .success(result.value);
      case Error<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }

  /// 获取是否开启安全生物特征识别
  Future<Result<bool>> getKeyBiometric() async {
    final keyBiometricResult = await _securityKeyRepository.getKeyBiometric();
    switch (keyBiometricResult) {
      case Success<bool?>():
        final resultValue = keyBiometricResult.value ?? false;
        LogUtils.stackTraceLog(StackTrace.current, result: keyBiometricResult);
        return .success(resultValue);
      case Error<bool?>():
        LogUtils.stackTraceLog(StackTrace.current, result: keyBiometricResult);
        return .error(keyBiometricResult.error);
    }
  }

  /// 设置是否开启安全生物特征识别
  Future<Result<bool>> setKeyBiometric(bool keyBiometric) async {
    final result = await _securityKeyRepository.setKeyBiometric(keyBiometric);
    switch (result) {
      case Success<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .success(result.value);
      case Error<bool>():
        LogUtils.stackTraceLog(StackTrace.current, result: result);
        return .error(result.error);
    }
  }
}
