import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  /// Brand
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryBlueLight = Color(0xFF60A5FA);
  static const Color primaryPurple = Color(0xFF8B5CF6);

  /// Dark Theme
  static const Color darkBg = Color(0xFF050505);
  static const Color darkBgSoft = Color(0xFF111113);
  static const Color darkCard = Color(0xFF1A1A1D);
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkTextMuted = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0x1FFFFFFF);
  static const Color darkGlass = Color(0x14FFFFFF);
  static const Color darkGlassBorder = Color(0x26FFFFFF);

  /// Light Theme
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color lightBgSoft = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);
  static const Color lightGlass = Color(0xB3FFFFFF);
  static const Color lightGlassBorder = Color(0xFFFFFFFF);

  /// Status
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color online = Color(0xFF22C55E);

  /// Buttons
  static const Color buttonBlue = Color(0xFF4285F4);
  static const Color buttonDisabled = Color(0x664285F4);

  static const Color transparent = Colors.transparent;

  /// Dark Gradient
  static const LinearGradient darkBgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF242323),
      Color(0xFF111111),
      Color(0xFF050505),
    ],
  );

  /// Light Gradient
  static const LinearGradient lightBgGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF8FAFC),
      Color(0xFFEFF6FF),
    ],
  );

  static const LinearGradient premiumGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1F2937),
      Color(0xFF7C3AED),
      Color(0xFFEF4444),
    ],
  );

  static const LinearGradient blueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [ primaryBlueLight, primaryBlue],
  );
}