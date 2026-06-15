// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_radius.dart';

class BottomSheetHelper {
  BottomSheetHelper._();

  static Future<T?> showGlassSheet<T>({
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    double radius = AppRadius.xxl,
    double maxHeightFactor = 0.90,
  }) {
    final context = Get.context!;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.55),
      builder: (context) {
        final media = MediaQuery.of(context);

        return AnimatedPadding(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.only(bottom: media.viewInsets.bottom),
          child: SafeArea(
            top: false,
            child: Container(
              constraints: BoxConstraints(maxHeight: media.size.height * maxHeightFactor),
              decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(radius))),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget handle({
    double width = 44,
    double height = 5,
    Color color = const Color(0xFFCBD5E1),
  }) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

