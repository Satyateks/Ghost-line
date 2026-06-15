import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBack;
  final bool glass;

  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.showBack = false,
    this.onBack,
    this.glass = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    final subColor = isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted;

    final content = SafeArea(
      bottom: false,
      child: Container(
        height: subtitle == null ? 64 : 74,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            leading ??
                (showBack
                    ? _CircleIconButton(
                        icon: Icons.arrow_back_ios_new_rounded,
                        onTap: onBack ?? () => Navigator.pop(context),
                      )
                    : const SizedBox(width: 42)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.h3(textColor).copyWith(fontSize: 17),
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.bodySmall(subColor),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 12),
            if (actions != null && actions!.isNotEmpty)
              Row(mainAxisSize: MainAxisSize.min, children: actions!)
            else
              const SizedBox(width: 42),
          ],
        ),
      ),
    );

    if (!glass) return content;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(AppRadius.lg),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          decoration: BoxDecoration(
            color: isDark
                ? Colors.black.withOpacity(0.18)
                : Colors.white.withOpacity(0.55),
            border: Border(
              bottom: BorderSide(
                color: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.white.withOpacity(0.9),
              ),
            ),
          ),
          child: content,
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        height: 42,
        width: 42,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.75),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.10)
                : Colors.white.withOpacity(0.95),
          ),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}