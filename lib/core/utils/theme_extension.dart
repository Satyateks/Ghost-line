// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../theme/app_colors.dart';


extension ThemeX on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colors => Theme.of(this).colorScheme;

  TextTheme get textStyles => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  bool get isLight => Theme.of(this).brightness == Brightness.light;

  Color get bgColor => Theme.of(this).scaffoldBackgroundColor;

  Color get primaryColor => Theme.of(this).colorScheme.primary;

  Color get textPrimary => isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;

  Color get textSecondary => isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;

  Color get textMuted => isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

  Color get cardColor => isDark ? AppColors.darkCard : AppColors.lightCard;

  Color get glassColor => isDark ? Colors.white.withOpacity(0.075) : Colors.white.withOpacity(0.72);

  Color get glassBorder => isDark ? Colors.white.withOpacity(0.10) : Colors.white.withOpacity(0.95);
}

