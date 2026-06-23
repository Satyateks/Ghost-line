// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../controller/user_profile_controller.dart';
import 'profile_option_card.dart';

class GroupBottomSheet {
  static Future<void> show({
    required BuildContext context,
    required UserProfileController controller,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.72),
      builder: (_) {
        return Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: const SizedBox(),
              ),
            ),

            Positioned(
              top: MediaQuery.of(context).padding.top + 14,
              left: 0,
              right: 0,
              child: Center(
                child: InkWell(
                  onTap: Get.back,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? Colors.black.withOpacity(0.48)
                          : Colors.white.withOpacity(0.72),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.12)
                            : Colors.black.withOpacity(0.08),
                      ),
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                      size: 28,
                    ),
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  12,
                  0,
                  12,
                  12 + MediaQuery.of(context).padding.bottom,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.black.withOpacity(0.54)
                            : Colors.white.withOpacity(0.82),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.12)
                              : Colors.white.withOpacity(0.95),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Group Settings',
                            style: TextStyle(
                              color: isDark ? Colors.white : AppColors.lightTextPrimary,
                              fontSize: 23,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.4,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Manage group preferences',
                            style: TextStyle(
                              color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: 24),

                          ProfileOptionCard(
                            options: controller.options,
                            onTap: (item) {
                              Get.back();
                              // Handle tap if needed
                            },
                            onToggle: (item) {
                              controller.toggleOption(item.type);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
