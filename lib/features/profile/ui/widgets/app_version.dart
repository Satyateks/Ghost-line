

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/utils/app_assets.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_scaffold.dart';

class AppVersionPage extends StatelessWidget {
  const AppVersionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassScaffold(safeArea: true,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [const SizedBox(height: 25),
          _Header(title: 'App Version'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ const SizedBox(height: 55),
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4F90FF), Color(0xFF3C81F6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Image.asset(AppAssets.ghostLogo, fit: BoxFit.cover),
                ),
                const SizedBox(height: 28),
                Text(
                  'Ghost line App',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Version 2.4.1 (Build 108)',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white60 : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 40),
                // अपडेट स्टेटस चिप
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, color: Color(0xFF10B981), size: 16),
                      const SizedBox(width: 8),
                      Text(
                        'Up to date',
                        style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('You are already using the latest version.')),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: isDark ? Colors.white24 : Colors.black12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Check for Updates',
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF1E293B),
                        fontWeight: FontWeight.w600,
                      ),
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


