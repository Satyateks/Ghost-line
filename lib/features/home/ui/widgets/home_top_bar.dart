import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/theme/theme_route.dart';
import '../../../../core/utils/utils_route.dart';
import '../../../chat_room/ui/forward_message_screen.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Image.asset(AppAssets.ghostLogo1, height: 40, width: 40, fit: BoxFit.contain),

          const Spacer(),

          InkWell(
            onTap: () => Get.to(() => ForwardMessageScreen(message: 'Satya..')),
            borderRadius: BorderRadius.circular(999),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark ? Colors.white.withOpacity(0.10) : AppColors.buttonBlue,
                // border: Border.all(color: isDark ? Colors.white.withOpacity(0.12) : Colors.black.withOpacity(0.08)),
              ),
              child: Icon(Icons.add_rounded, size: 21, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
