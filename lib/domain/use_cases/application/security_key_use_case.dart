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
        return Result.success(keyPasswordResult.value ?? '');
      case Error<String?>():
        print('SecurityKeyUseCase error: ${keyPasswordResult.error}');
        return Result.error(keyPasswordResult.error);
    }
  }

  /// 设置安全密码内容
  Future<Result<bool>> setKeyPassword(String keyPassword) async {
    return _securityKeyRepository.setKeyPassword(keyPassword);
  }

  /// 获取是否开启安全生物特征识别
  Future<Result<bool>> getKeyBiometric() async {
    final keyBiometricResult = await _securityKeyRepository.getKeyBiometric();
    switch (keyBiometricResult) {
      case Success<bool?>():
        return Result.success(keyBiometricResult.value ?? false);
      case Error<bool?>():
        print('SecurityKeyUseCase error: ${keyBiometricResult.error}');
        return Result.error(keyBiometricResult.error);
    }
  }

  /// 设置是否开启安全生物特征识别
  Future<Result<bool>> setKeyBiometric(bool keyBiometric) async {
    return _securityKeyRepository.setKeyBiometric(keyBiometric);
  }
}
