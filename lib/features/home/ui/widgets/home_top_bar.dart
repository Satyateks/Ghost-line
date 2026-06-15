import 'package:flutter/material.dart';
import '../../../../core/theme/theme_route.dart';
import '../../../../core/utils/utils_route.dart';


class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Image.asset(
            AppAssets.ghostLogo1,
            height: 30, width: 30,
            fit: BoxFit.contain,
          ),

          const Spacer(),

          InkWell(
            onTap: () {
              // Add new chat/group
            },
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? Colors.white.withOpacity(0.10)
                    : Colors.black.withOpacity(0.06),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.12)
                      : Colors.black.withOpacity(0.08),
                ),
              ),
              child: Icon(
                Icons.add_rounded,
                size: 21,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}