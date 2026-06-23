import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_scaffold.dart';


class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassScaffold(safeArea: true,
      body: Column( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const SizedBox(height: 25),
          _Header(title: 'Privacy Policy'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(
                  "Your privacy matters to us. Learn how we handle your personal data safely.",
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? Colors.white60 : const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 24),
                _buildPolicyTile(
                  icon: Icons.shield_outlined,
                  title: "Data Protection",
                  subtitle: "We use enterprise-grade encryption to protect your personal details, chats, and property documents.",
                  isDark: isDark,
                ),
                _buildPolicyTile(
                  icon: Icons.location_on_outlined,
                  title: "Location Sharing",
                  subtitle: "We only access your location with your explicit permission to show nearby properties.",
                  isDark: isDark,
                ),
                _buildPolicyTile(
                  icon: Icons.lock_outlined,
                  title: "Third-Party Sharing",
                  subtitle: "Your private communication, audio logs, and phone numbers are never sold to advertisers.",
                  isDark: isDark,
                ),
                _buildPolicyTile(
                  icon: Icons.delete_forever_outlined,
                  title: "Account Deletion",
                  subtitle: "You have the right to request full deletion of your profile and historical logs from our databases at any time.",
                  isDark: isDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyTile({required IconData icon, required String title, required String subtitle, required bool isDark}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: isDark 
          ? [] 
          : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF4F90FF), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.5,
                    height: 1.4,
                    color: isDark ? Colors.white60 : const Color(0xFF475569),
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




