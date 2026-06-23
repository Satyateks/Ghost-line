

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/glass_scaffold.dart';

class TermsConditionPage extends StatelessWidget {
  const TermsConditionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GlassScaffold(safeArea: true,
      body: Column( crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const SizedBox(height: 25),
          _Header(title: 'Terms & Conditions'),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildSection(
                  context,
                  title: "1. Acceptance of Terms",
                  content: "By accessing and using this application, you agree to be bound by these terms and conditions. If you do not agree, please refrain from using the services.",
                  isDark: isDark,
                ),
                _buildSection(
                  context,
                  title: "2. User Eligibility & Account",
                  content: "You are responsible for maintaining the confidentiality of your account credentials. Any fraudulent, abusive, or otherwise illegal activity may be grounds for termination.",
                  isDark: isDark,
                ),
                _buildSection(
                  context,
                  title: "3. Payments & Real Estate Transactions",
                  content: "All property listings, subscription plans, and premium payments are final. The app acts as a platform to connect users, and final agreements are the sole responsibility of the parties involved.",
                  isDark: isDark,
                ),
                _buildSection(
                  context,
                  title: "4. Limitation of Liability",
                  content: "We are not liable for any damages, losses, or disputes arising between tenants, property owners, or buyers using our platform.",
                  isDark: isDark,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    "Last updated: June 2026",
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

  Widget _buildSection(BuildContext context, {required String title, required String content, required bool isDark}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? const Color(0xFF4F90FF) : const Color(0xFF1E3A8A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? Colors.white70 : const Color(0xFF475569),
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



