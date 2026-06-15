import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/avatar_widget.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String username;
  final String phone;
  final String avatar;
  final VoidCallback onSwitch;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.username,
    required this.phone,
    required this.avatar,
    required this.onSwitch,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final subColor = isDark ? Colors.white70 : AppColors.lightTextSecondary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(34),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.12)
                : Colors.white.withOpacity(0.82),
            borderRadius: BorderRadius.circular(34),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.12)
                  : Colors.white.withOpacity(0.95),
            ),
          ),
          child: Row(
            children: [
              AvatarWidget(
                name: name,
                imageUrl: avatar,
                size: 82,
                showStatus: false,
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: titleColor,
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      username,
                      style: TextStyle(
                        color: subColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      phone,
                      style: TextStyle(
                        color: subColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: onSwitch,
                child: const Text(
                  'Switch account',
                  style: TextStyle(
                    color: AppColors.buttonBlue,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}