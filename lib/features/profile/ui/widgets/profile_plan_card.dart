import 'dart:ui';
import 'package:flutter/material.dart';


class ProfilePlanCard extends StatelessWidget {
  const ProfilePlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final contentColor = isDark ? Colors.white : const Color(0xFF1E3A8A); 

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color(0xFF4F90FF).withOpacity(isDark ? 0.35 : 0.25), 
                const Color(0x003C81F6),
              ],
            ),
            // border: Border.all(color: const Color(0xFF4F90FF).withOpacity(isDark ? 0.2 : 0.25), width: 0.5),
          ),
          child: Row(
            children: [
              Icon(
                Icons.star_rounded,
                color: isDark ? const Color(0xFF4F90FF) : const Color(0xFF3C81F6),
                size: 27,
              ),
              const SizedBox(width: 9),
              Text(
                'Quarterly plan',
                style: TextStyle(
                  color: isDark ? Colors.white70 : contentColor.withOpacity(0.85),
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                'Premium User',
                style: TextStyle(
                  color: contentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






