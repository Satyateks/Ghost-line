import 'package:flutter/material.dart';
import '../../core/utils/app_constants.dart';
import '../services/storage_service.dart';

class ThemeRepository {
  final StorageService _storage = StorageService.instance;

  ThemeMode getThemeMode() {
    final value = _storage.read<String>(AppConstants.themeKey);

    switch (value) {
      case 'light': return ThemeMode.light;
      case 'dark': return ThemeMode.dark;
      case 'system':
      default: return ThemeMode.system;
    }
  }

  Future<void> saveThemeMode(ThemeMode mode) async {
    String value;

    switch (mode) {
      case ThemeMode.light: value = 'light'; break;
      case ThemeMode.dark: value = 'dark'; break;
      case ThemeMode.system: value = 'system'; break;
    }

    await _storage.write(AppConstants.themeKey, value);
  }
}
