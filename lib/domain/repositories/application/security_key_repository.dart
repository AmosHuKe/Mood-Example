import '../../../utils/result.dart';

abstract class SecurityKeyRepository {
  /// 获取安全密码内容
  Future<Result<String?>> getKeyPassword();

  /// 设置安全密码内容
  Future<Result<bool>> setKeyPassword(String keyPassword);

  /// 获取是否开启安全生物特征识别
  Future<Result<bool?>> getKeyBiometric();

  /// 设置是否开启安全生物特征识别
  Future<Result<bool>> setKeyBiometric(bool keyBiometric);
}
