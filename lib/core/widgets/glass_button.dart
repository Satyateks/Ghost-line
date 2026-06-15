import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';

class GlassButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;
  final double height;
  final double radius;
  final IconData? icon;
  final bool isPrimary;
  final Color? backgroundColor;
  final Color? textColor;

  const GlassButton({
    super.key,
    required this.title,
    required this.onTap,
    this.isLoading = false,
    this.height = 46,
    this.radius = AppRadius.full,
    this.icon,
    this.isPrimary = true,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null || isLoading;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = backgroundColor ??
        (isPrimary
            ? AppColors.buttonBlue
            : isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.75));

    final fgColor = textColor ??
        (isPrimary
            ? Colors.white
            : isDark
                ? Colors.white
                : AppColors.lightTextPrimary);

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: SizedBox(
          width: double.infinity,
          height: height,
          child: ElevatedButton(
            onPressed: isDisabled ? null : onTap,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: isDisabled ? bgColor.withOpacity(0.45) : bgColor,
              foregroundColor: fgColor,
              disabledBackgroundColor: bgColor.withOpacity(0.45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius),
                side: BorderSide(
                  color: isPrimary
                      ? Colors.transparent
                      : Colors.white.withOpacity(isDark ? 0.12 : 0.85),
                ),
              ),
            ),
            child: isLoading
                ? SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: fgColor,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: AppTextStyles.button(fgColor),
                      ),
                      if (icon != null) ...[
                        const SizedBox(width: 8),
                        Icon(icon, size: 18, color: fgColor),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}