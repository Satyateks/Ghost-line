import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../model/profile_models.dart';

class ProfileMenuCard extends StatelessWidget {
  final List<ProfileMenuModel> menus;
  final ValueChanged<ProfileMenuModel> onTap;
  final VoidCallback onLogout;

  const ProfileMenuCard({
    super.key,
    required this.menus,
    required this.onTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(34),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
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
          child: Column(
            children: [
              ...List.generate(menus.length, (index) {
                final menu = menus[index];

                return _ProfileMenuTile(
                  menu: menu,
                  showDivider: true,
                  onTap: () => onTap(menu),
                );
              }),

              InkWell(
                onTap: onLogout,
                child: SizedBox(
                  height: 62,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout_rounded,
                        color: AppColors.error,
                        size: 27,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Log out of this account',
                          style: TextStyle(
                            color: AppColors.error,
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
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

class _ProfileMenuTile extends StatelessWidget {
  final ProfileMenuModel menu;
  final bool showDivider;
  final VoidCallback onTap;

  const _ProfileMenuTile({
    required this.menu,
    required this.showDivider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 62,
            child: Row(
              children: [
                Icon(menu.icon, color: textColor, size: 27),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    menu.title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 23,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: textColor,
                  size: 22,
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: isDark
                ? Colors.white.withOpacity(0.10)
                : Colors.black.withOpacity(0.08),
          ),
        ],
      ),
    );
  }
}