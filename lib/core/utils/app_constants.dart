class AppConstants {
  AppConstants._();

  /// App
  static const String appName = 'GhostLine';
  static const String appVersion = '1.0.0';

  /// Storage Keys
  static const String tokenKey = 'token';
  static const String userIdKey = 'user_id';
  static const String themeKey = 'theme_mode';
  static const String isLoggedInKey = 'is_logged_in';

  /// API
  static const String baseUrl = '';
  static const int connectTimeout = 30000;
  static const int receiveTimeout = 30000;

  /// Animation Duration
  static const Duration fastDuration = Duration(milliseconds: 180);
  static const Duration normalDuration = Duration(milliseconds: 280);
  static const Duration slowDuration = Duration(milliseconds: 450);

  /// Design Base Size
  /// Figma frame ke according update kar sakte ho.
  static const double designWidth = 390;
  static const double designHeight = 844;

  /// Chat
  static const int maxMessageLength = 1000;
  static const int maxOtpLength = 6;
}
