// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';


class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionCircle(
          icon: Icons.call_outlined,
          onTap: () {},
        ),
        const SizedBox(width: 18),
        _ActionCircle(
          icon: Icons.videocam_outlined,
          isPrimary: true,
          onTap: () {},
        ),
        const SizedBox(width: 18),
        _ActionCircle(
          icon: Icons.chat_bubble_outline_rounded,
          onTap: () {},
        ),
      ],
    );
  }
}

class _ActionCircle extends StatelessWidget {
  final IconData icon;
  final bool isPrimary;
  final VoidCallback onTap;

  const _ActionCircle({
    required this.icon,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: 68,
            width: 68,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isPrimary
                  ? AppColors.buttonBlue.withOpacity(0.55)
                  : isDark
                      ? Colors.white.withOpacity(0.16)
                      : Colors.white.withOpacity(0.72),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.20)
                    : Colors.white.withOpacity(0.95),
              ),
            ),
            child: Icon(
              icon,
              size: 31,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          ),
        ),
      ),
    );
  }
}