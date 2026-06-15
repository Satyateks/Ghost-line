import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../model/profile_models.dart';

class SettingActionSheet {
  static Future<void> show({
    required BuildContext context,
    required SettingItemModel item,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.65),
      builder: (_) {
        return Padding(
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
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withOpacity(0.62)
                      : Colors.white.withOpacity(0.88),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.12)
                        : Colors.white.withOpacity(0.95),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      color: item.isDanger
                          ? AppColors.error
                          : AppColors.buttonBlue,
                      size: 34,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: item.isDanger
                            ? AppColors.error
                            : isDark
                                ? Colors.white
                                : AppColors.lightTextPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _description(item),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white70
                            : AppColors.lightTextSecondary,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: OutlinedButton(
                              onPressed: Get.back,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.18)
                                      : Colors.black.withOpacity(0.12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: isDark ? Colors.white : Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: Get.back,
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: item.isDanger
                                    ? AppColors.error
                                    : AppColors.buttonBlue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: const Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
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

  static String _description(SettingItemModel item) {
    switch (item.type) {
      case SettingItemType.changeUserName:
        return 'Update your username. Your friends will see your new username after update.';
      case SettingItemType.changeNumber:
        return 'Change your mobile number linked with this account.';
      case SettingItemType.deleteAccount:
        return 'This will permanently delete your account, chats, media and settings.';
      case SettingItemType.removeAccount:
        return 'This account will be removed from this device only.';
      case SettingItemType.lastSeenOnline:
        return 'Choose who can see your last seen and online status.';
      case SettingItemType.profilePhoto:
        return 'Choose who can see your profile photo.';
      case SettingItemType.about:
        return 'Manage who can see your about information.';
      case SettingItemType.status:
        return 'Manage who can see your status updates.';
      case SettingItemType.posts:
        return 'Manage who can see your posts.';
      case SettingItemType.phoneNumber:
        return 'Choose who can see your phone number.';
      case SettingItemType.groups:
        return 'Choose who can add you to groups.';
      default:
        return 'Manage this setting for your account.';
    }
  }
}