import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthRepository {
  final ApiService _api = ApiService.instance;
  final StorageService _storage = StorageService.instance;

  Future<Map<String, dynamic>> login({
    required String emailOrMobile,
    required String password,
  }) async {
    final response = await _api.post(
      '/auth/login',
      data: {
        'email_or_mobile': emailOrMobile,
        'password': password,
      },
    );

    final data = Map<String, dynamic>.from(response.data);

    final token = data['token']?.toString();
    final userId = data['user']?['id']?.toString();

    if (token != null && token.isNotEmpty) {
      await _storage.saveToken(token);
      await _storage.setLoggedIn(true);
    }

    if (userId != null && userId.isNotEmpty) {
      await _storage.saveUserId(userId);
    }

    return data;
  }

  Future<Map<String, dynamic>> register({
    required String emailOrMobile,
    required String password,
  }) async {
    final response = await _api.post(
      '/auth/register',
      data: {
        'email_or_mobile': emailOrMobile,
        'password': password,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> verifyOtp({
    required String emailOrMobile,
    required String otp,
  }) async {
    final response = await _api.post(
      '/auth/verify-otp',
      data: {
        'email_or_mobile': emailOrMobile,
        'otp': otp,
      },
    );

    final data = Map<String, dynamic>.from(response.data);

    final token = data['token']?.toString();
    final userId = data['user']?['id']?.toString();

    if (token != null && token.isNotEmpty) {
      await _storage.saveToken(token);
      await _storage.setLoggedIn(true);
    }

    if (userId != null && userId.isNotEmpty) {
      await _storage.saveUserId(userId);
    }

    return data;
  }

  Future<Map<String, dynamic>> resendOtp({
    required String emailOrMobile,
  }) async {
    final response = await _api.post(
      '/auth/resend-otp',
      data: {
        'email_or_mobile': emailOrMobile,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<Map<String, dynamic>> chooseUsername({
    required String username,
  }) async {
    final response = await _api.post(
      '/auth/choose-username',
      data: {
        'username': username,
      },
    );

    return Map<String, dynamic>.from(response.data);
  }

  Future<void> logout() async {
    try {
      await _api.post('/auth/logout');
    } catch (_) {
      // API fail ho jaye tab bhi local logout karna safe hai.
    }

    await _storage.logout();
  }

  bool get isLoggedIn => _storage.isLoggedIn;
}