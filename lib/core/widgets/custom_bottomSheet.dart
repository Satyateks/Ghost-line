import 'dart:ui';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';



class CustomContentBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    EdgeInsets padding = const EdgeInsets.fromLTRB(16, 16, 16, 20),
    bool isDismissible = true,
    bool enableDrag = true,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(.68),
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            left: 8,
            right: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 14,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: Container(
                width: double.infinity,
                padding: padding,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(.09)
                      : Colors.white.withOpacity(.82),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(.12)
                        : Colors.white.withOpacity(.95),
                  ),
                ),
                child: child,
              ),
            ),
          ),
        );
      },
    );
  }
}




class CustomBottomSheet {
  static Future<void> show({
    required BuildContext context,

    // Content
    required String title,
    required String description,

    // Buttons
    String cancelText = "Cancel",
    String actionText = "Continue",

    // Callbacks
    VoidCallback? onCancel,
    required VoidCallback onAction,

    // Colors
    Color actionButtonColor = AppColors.buttonBlue,
    Color? actionTextColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.68),
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.09)
                      : Colors.white.withOpacity(0.82),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.12)
                        : Colors.white.withOpacity(0.95),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                        fontSize: 13,
                        height: 1.3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onCancel?.call();
                              },
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: isDark
                                      ? Colors.white.withOpacity(.15)
                                      : Colors.black12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Text(
                                cancelText,
                                style: TextStyle(
                                  color:
                                      isDark ? Colors.white : Colors.black87,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                onAction();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: actionButtonColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Text(
                                actionText,
                                style: TextStyle(
                                  color: actionTextColor ?? Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}