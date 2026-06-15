import 'package:get_storage/get_storage.dart';
import '../../core/utils/app_constants.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  final GetStorage _box = GetStorage();

  Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  T? read<T>(String key) {
    return _box.read<T>(key);
  }

  Future<void> remove(String key) async {
    await _box.remove(key);
  }

  Future<void> clear() async {
    await _box.erase();
  }

  Future<void> saveToken(String token) async {
    await write(AppConstants.tokenKey, token);
  }

  String? get token {
    return read<String>(AppConstants.tokenKey);
  }

  bool get hasToken {
    final value = token;
    return value != null && value.isNotEmpty;
  }

  Future<void> saveUserId(String userId) async {
    await write(AppConstants.userIdKey, userId);
  }

  String? get userId {
    return read<String>(AppConstants.userIdKey);
  }

  Future<void> setLoggedIn(bool value) async {
    await write(AppConstants.isLoggedInKey, value);
  }

  bool get isLoggedIn {
    return read<bool>(AppConstants.isLoggedInKey) ?? false;
  }

  Future<void> logout() async {
    await remove(AppConstants.tokenKey);
    await remove(AppConstants.userIdKey);
    await setLoggedIn(false);
  }
}
