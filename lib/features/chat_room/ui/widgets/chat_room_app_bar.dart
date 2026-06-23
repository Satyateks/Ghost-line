import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/utils/utils_route.dart';

import '../../../../core/theme/theme_route.dart';
import '../../../../core/widgets/widgets_route.dart';
import '../../../user_profile/ui/user_profile_screen.dart';

class ChatRoomAppBar extends StatelessWidget {
  final String name;
  final String avatar;

  const ChatRoomAppBar({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
      child: Row(
        children: [
          _CircleGlassButton(icon: Icons.arrow_back_ios_new_rounded, onTap: Get.back),

          const SizedBox(width: 12),

        /*  AvatarWidget(name: name, imageUrl: avatar, size: 34, showStatus: false),
          const SizedBox(width: 8),
          Expanded(
            child: Text( name, maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle( color: textColor, fontSize: 16, fontWeight: FontWeight.w700)),
          ),*/
          Expanded(
            child: InkWell(
              onTap: ()=> Get.to(UserProfileScreen(name: name, avatar: avatar)),
              borderRadius: BorderRadius.circular(999),
              child: Row(
                children: [
                  AvatarWidget(
                    name: name,
                    imageUrl: avatar,
                    size: 40,
                    showStatus: true,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Container(
                height: 42,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.08) : Colors.white.withOpacity(0.76),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: isDark ? Colors.white.withOpacity(0.10) : Colors.white.withOpacity(0.95)),
                ),
                child: Row(
                  children: [
                    Image.asset(AppAssets.videoIcon,height: 22, color: textColor),
                    const SizedBox(width: 14),
                    Image.asset(AppAssets.callIcon,height: 22, color: textColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleGlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleGlassButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(80),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(80),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.white.withOpacity(0.76),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.10)
                    : Colors.white.withOpacity(0.95),
              ),
            ),
            child: Icon( icon, size: 24,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

