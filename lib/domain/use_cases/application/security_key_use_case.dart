import '../../../utils/log_utils.dart';
import '../../../utils/result.dart';
import '../../repositories/application/security_key_repository.dart';

class SecurityKeyUseCase {
  SecurityKeyUseCase({required SecurityKeyRepository securityKeyRepository})
    : _securityKeyRepository = securityKeyRepository;

  final SecurityKeyRepository _securityKeyRepository;

  void _log(Object? value, {Result<Object?> result = const .success(null)}) {
    LogUtils.log('${'[${this.runtimeType}]'.blue} ${value}', result: result);
  }

  /// 获取安全密码内容
  Future<Result<String>> getKeyPassword() async {
    final keyPasswordResult = await _securityKeyRepository.getKeyPassword();
    switch (keyPasswordResult) {
      case Success<String?>():
        _log('${getKeyPassword.toString()} ${keyPasswordResult.value}', result: keyPasswordResult);
        return .success(keyPasswordResult.value ?? '');
      case Error<String?>():
        _log('${getKeyPassword.toString()} ${keyPasswordResult.error}', result: keyPasswordResult);
        return .error(keyPasswordResult.error);
    }
  }

  /// 设置安全密码内容
  Future<Result<bool>> setKeyPassword(String keyPassword) async {
    final result = await _securityKeyRepository.setKeyPassword(keyPassword);
    switch (result) {
      case Success<bool>():
        _log('${setKeyPassword.toString()} ${keyPassword}', result: result);
        return .success(result.value);
      case Error<bool>():
        _log('${setKeyPassword.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }

  /// 获取是否开启安全生物特征识别
  Future<Result<bool>> getKeyBiometric() async {
    final keyBiometricResult = await _securityKeyRepository.getKeyBiometric();
    switch (keyBiometricResult) {
      case Success<bool?>():
        final resultValue = keyBiometricResult.value ?? false;
        _log('${getKeyBiometric.toString()} ${resultValue}', result: keyBiometricResult);
        return .success(resultValue);
      case Error<bool?>():
        _log(
          '${getKeyBiometric.toString()} ${keyBiometricResult.error}',
          result: keyBiometricResult,
        );
        return .error(keyBiometricResult.error);
    }
  }

  /// 设置是否开启安全生物特征识别
  Future<Result<bool>> setKeyBiometric(bool keyBiometric) async {
    final result = await _securityKeyRepository.setKeyBiometric(keyBiometric);
    switch (result) {
      case Success<bool>():
        _log('${setKeyBiometric.toString()} ${keyBiometric}', result: result);
        return .success(result.value);
      case Error<bool>():
        _log('${setKeyBiometric.toString()} ${result.error}', result: result);
        return .error(result.error);
    }
  }
}
