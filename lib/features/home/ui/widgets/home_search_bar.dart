import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme_route.dart';


class HomeSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const HomeSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: AppRadius.xxllRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: SizedBox(
            height: 38,
            child: TextField(
              onChanged: onChanged,
              cursorColor: AppColors.primaryBlue,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark ? Colors.white.withOpacity(0.10) : Colors.white.withOpacity(0.75),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 24,
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
                hintText: 'Search friends, chat, media or groups',
                hintStyle: TextStyle(
                  color: isDark ? Colors.white54 : Colors.black45,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w500,
                ),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}