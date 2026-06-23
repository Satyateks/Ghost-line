import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_scaffold.dart';

class AppInfoPage extends StatelessWidget {
  const AppInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassScaffold(
      safeArea: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          _Header(title: 'App Info'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildInfoSection(
                  context,
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      color: isDark ? Colors.white38 : Colors.black38,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, {required bool isDark}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.12)
            : Colors.white.withOpacity(0.86),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.12)
              : Colors.white.withOpacity(0.95),
        ),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            context,
            icon: Icons.info_outline,
            label: 'App Name',
            value: 'GhostLine',
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            icon: Icons.android,
            label: 'Platform',
            value: 'iOS & Android',
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            icon: Icons.code,
            label: 'Build',
            value: 'Flutter',
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          _buildInfoRow(
            context,
            icon: Icons.calendar_today_outlined,
            label: 'Released',
            value: 'June 2026',
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required bool isDark,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryBlue,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? Colors.white70 : AppColors.lightTextSecondary,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isDark ? Colors.white : AppColors.lightTextPrimary,
          ),
        ),
      ],
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
      borderRadius: BorderRadius.circular(80),
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.78),
          borderRadius: BorderRadius.circular(80),
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