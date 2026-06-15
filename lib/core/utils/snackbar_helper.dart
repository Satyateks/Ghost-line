// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';

class SnackbarHelper {
  SnackbarHelper._();

  static void success(String message, {String title = 'Success'}) {
    _show(
      title: title,
      message: message,
      icon: Icons.check_circle_rounded,
      color: AppColors.success,
    );
  }

  static void error(String message, {String title = 'Error'}) {
    _show(
      title: title,
      message: message,
      icon: Icons.error_rounded,
      color: AppColors.error,
    );
  }

  static void warning(String message, {String title = 'Warning'}) {
    _show(
      title: title,
      message: message,
      icon: Icons.warning_amber_rounded,
      color: AppColors.warning,
    );
  }

  static void info(String message, {String title = 'Info'}) {
    _show(
      title: title,
      message: message,
      icon: Icons.info_rounded,
      color: AppColors.primaryBlue,
    );
  }

  static void _show({
    required String title,
    required String message,
    required IconData icon,
    required Color color,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      borderRadius: 18,
      backgroundColor: color.withOpacity(0.95),
      colorText: Colors.white,
      icon: Icon(icon, color: Colors.white),
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 250),
      shouldIconPulse: false,
    );
  }
}
