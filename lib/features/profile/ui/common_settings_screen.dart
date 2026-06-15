import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../model/profile_models.dart';
import 'account_settings_screen.dart';


class CommonSettingsScreen extends StatelessWidget {
  final String title;
  final List<SettingItemModel> items;

  const CommonSettingsScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      safeArea: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 10, 14, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(title: title),
            const SizedBox(height: 20),
            _Card(
              items: items,
              onTap: (item) {
                SettingActionSheet.show(
                  context: context,
                  item: item,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;

  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: Get.back,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.78),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 15,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final List<SettingItemModel> items;
  final ValueChanged<SettingItemModel> onTap;

  const _Card({
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.12)
            : Colors.white.withOpacity(0.86),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.12)
              : Colors.white.withOpacity(0.95),
        ),
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final item = items[index];

          return InkWell(
            onTap: () => onTap(item),
            child: Column(
              children: [
                SizedBox(
                  height: 70,
                  child: Row(
                    children: [
                      Icon(
                        item.icon,
                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        size: 27,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: TextStyle(
                                color: isDark
                                    ? Colors.white
                                    : AppColors.lightTextPrimary,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (item.subtitle != null) ...[
                              const SizedBox(height: 3),
                              Text(
                                item.subtitle!,
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white60
                                      : AppColors.lightTextMuted,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: isDark ? Colors.white : AppColors.lightTextPrimary,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                if (index != items.length - 1)
                  Divider(
                    height: 1,
                    color: isDark
                        ? Colors.white.withOpacity(0.10)
                        : Colors.black.withOpacity(0.08),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}