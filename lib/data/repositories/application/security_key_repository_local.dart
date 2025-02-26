import '../../../utils/result.dart';
import '../../../domain/repositories/application/security_key_repository.dart';
import '../../dao/application/security_key_dao.dart';

class SecurityKeyRepositoryLocal implements SecurityKeyRepository {
  SecurityKeyRepositoryLocal({required SecurityKeyDao securityKeyDao})
    : _securityKeyDao = securityKeyDao;

  final SecurityKeyDao _securityKeyDao;

  @override
  Future<Result<String?>> getKeyPassword() async {
    try {
      final value = await _securityKeyDao.getAppKeyPassword();
      return Result.success(value);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> setKeyPassword(String keyPassword) async {
    try {
      await _securityKeyDao.setAppKeyPassword(keyPassword);
      return const Result.success(true);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool?>> getKeyBiometric() async {
    try {
      final value = await _securityKeyDao.getAppKeyBiometric();
      return Result.success(value);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<bool>> setKeyBiometric(bool keyBiometric) async {
    try {
      await _securityKeyDao.setAppKeyBiometric(keyBiometric);
      return const Result.success(true);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
