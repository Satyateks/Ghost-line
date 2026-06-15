import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme_route.dart';

class CallsSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CallsSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: SizedBox(
            height: 42,
            child: TextField(
              onChanged: onChanged,
              cursorColor: AppColors.buttonBlue,
              style: TextStyle(
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
                fontSize: 14,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: isDark
                    ? Colors.white.withOpacity(0.08)
                    : Colors.white.withOpacity(0.76),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 20,
                  color: isDark ? Colors.white54 : Colors.black45,
                ),
                hintText: 'Search name, numbers',
                hintStyle: TextStyle(
                  color: isDark ? Colors.white54 : Colors.black45,
                  fontSize: 14,
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