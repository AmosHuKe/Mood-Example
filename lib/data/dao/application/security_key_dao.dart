import '../../database/shared_preferences_db.dart';

class SecurityKeyDao {
  SecurityKeyDao({required SharedPreferencesDB sharedPreferencesDB})
    : _sharedPreferencesDB = sharedPreferencesDB;

  final SharedPreferencesDB _sharedPreferencesDB;

  /// 设置 - 安全密码
  Future<void> setAppKeyPassword(String keyPassword) async {
    await _sharedPreferencesDB.sps.setString(SharedPreferencesKey.appKeyPassword, keyPassword);
  }

  /// 获取 - 安全密码
  Future<String?> getAppKeyPassword() async {
    return _sharedPreferencesDB.sps.getString(SharedPreferencesKey.appKeyPassword);
  }

  /// 设置 - 是否开启安全生物特征识别
  Future<void> setAppKeyBiometric(bool keyBiometric) async {
    await _sharedPreferencesDB.sps.setBool(SharedPreferencesKey.appKeyBiometric, keyBiometric);
  }

  /// 获取 - 是否开启安全生物特征识别
  Future<bool?> getAppKeyBiometric() async {
    return _sharedPreferencesDB.sps.getBool(SharedPreferencesKey.appKeyBiometric);
  }
}
