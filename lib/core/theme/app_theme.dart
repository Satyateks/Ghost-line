// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_radius.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    bg: AppColors.lightBg,
    card: AppColors.lightCard,
    textPrimary: AppColors.lightTextPrimary,
    textSecondary: AppColors.lightTextSecondary,
    textMuted: AppColors.lightTextMuted,
    border: AppColors.lightBorder,
    inputFill: Colors.white,
  );

  static ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    bg: AppColors.darkBg,
    card: AppColors.darkCard,
    textPrimary: AppColors.darkTextPrimary,
    textSecondary: AppColors.darkTextSecondary,
    textMuted: AppColors.darkTextMuted,
    border: AppColors.darkBorder,
    inputFill: Colors.white.withOpacity(0.08),
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color bg,
    required Color card,
    required Color textPrimary,
    required Color textSecondary,
    required Color textMuted,
    required Color border,
    required Color inputFill,
  }) {
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppTextStyles.fontFamily,
      scaffoldBackgroundColor: bg,
      primaryColor: AppColors.primaryBlue,

      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primaryBlue,
        onPrimary: Colors.white,
        secondary: AppColors.primaryPurple,
        onSecondary: Colors.white,
        error: AppColors.error,
        onError: Colors.white,
        surface: card,
        onSurface: textPrimary,
      ),

      textTheme: TextTheme(
        displayLarge: AppTextStyles.h1(textPrimary),
        displayMedium: AppTextStyles.h2(textPrimary),
        displaySmall: AppTextStyles.h3(textPrimary),
        bodyLarge: AppTextStyles.bodyLarge(textPrimary),
        bodyMedium: AppTextStyles.bodyMedium(textSecondary),
        bodySmall: AppTextStyles.bodySmall(textMuted),
        labelLarge: AppTextStyles.button(Colors.white),
      ),

      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: AppTextStyles.h3(textPrimary),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        hintStyle: AppTextStyles.authHint(textMuted),
        labelStyle: AppTextStyles.bodySmall(textMuted),
        errorStyle: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: AppColors.error,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        border: _inputBorder(border),
        enabledBorder: _inputBorder(border),
        focusedBorder: _inputBorder(AppColors.primaryBlue, width: 1.2),
        errorBorder: _inputBorder(AppColors.error),
        focusedErrorBorder: _inputBorder(AppColors.error),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.buttonDisabled,
          elevation: 0,
          shadowColor: Colors.transparent,
          textStyle: AppTextStyles.button(Colors.white),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.authButton),
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          textStyle: AppTextStyles.button(AppColors.primaryBlue),
        ),
      ),

      iconTheme: IconThemeData(color: textPrimary),

      dividerTheme: DividerThemeData(
        color: isDark ? Colors.white.withOpacity(0.08) : AppColors.lightBorder,
        thickness: 1,
      ),

      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
        modalBackgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.bottomSheetRadius,
        ),
      ),
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.authField),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
