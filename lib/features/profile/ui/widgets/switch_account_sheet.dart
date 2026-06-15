import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';
import '../../model/profile_models.dart';

class SwitchAccountSheet {
  static Future<void> show({
    required BuildContext context,
    required List<SwitchUserModel> users,
    required ValueChanged<SwitchUserModel> onSelect,
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
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withOpacity(0.62)
                      : Colors.white.withOpacity(0.86),
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
                    Text(
                      'Switch account',
                      style: TextStyle(
                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 18),

                    ...users.map(
                      (user) => InkWell(
                        onTap: () => onSelect(user),
                        borderRadius: BorderRadius.circular(18),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              AvatarWidget(
                                name: user.name,
                                imageUrl: user.avatar,
                                size: 54,
                                showStatus: false,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.name,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white
                                            : AppColors.lightTextPrimary,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      user.phone,
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.white60
                                            : AppColors.lightTextMuted,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (user.isCurrent)
                                const Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.buttonBlue,
                                ),
                            ],
                          ),
                        ),
                      ),
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