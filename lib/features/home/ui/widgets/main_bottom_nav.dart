import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/theme_route.dart';
import '../../../../core/utils/utils_route.dart';
import '../../../call/ui/calls_screen.dart';
import '../../../profile/ui/profile_screen.dart';
import '../../../update/ui/updates_screen.dart';
import '../../../voiceMall/ui/voicemail_screen.dart';
import '../../controller/home_controller.dart';
import '../home_screen.dart';

 
class MainBottomNav extends StatelessWidget {
  final HomeController controller;

  const MainBottomNav({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final items = [
      _BottomItem(image: AppAssets.callIcon, title: 'Calls', type: BottomTabType.calls),
      _BottomItem(image: AppAssets.commentIcons, title: 'Chat', type: BottomTabType.chat),
      _BottomItem(image: AppAssets.voicemailIcon, title: 'Voicemail', type: BottomTabType.voicemail),
      _BottomItem(image: AppAssets.updateIcon, title: 'Updates', type: BottomTabType.updates),
      _BottomItem(image: AppAssets.userIcon, title: 'Profile', type: BottomTabType.profile),
    ];

    return SafeArea(top: false, left: false, right: false, bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 0, 14, 21), // Adjusted for a better floating look
        child: Container(
          // Subtle drop shadow to lift the glass bar off the background content
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.full),
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.black.withOpacity(0.2) : Colors.black.withOpacity(0.06),
                blurRadius: 20,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
              child: Container(
                height: 66, // Slightly increased height for vertical breathing room
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  // Premium semi-transparent tint for both modes
                  color: isDark ? Colors.white.withOpacity(0.06) : Colors.white.withOpacity(0.15), 
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    // Faux-reflective border edge
                    color: isDark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.4),
                    width: 1.2,
                  ),
                ),
                child: Row(
                  children: items.map((item) {
                    return Expanded(
                      child: Obx(() {
                        final selected = controller.selectedBottomTab.value == item.type;
                        final selectedColor = isDark ? AppColors.darkTextPrimary : AppColors.darkCard;
                        final unselectedColor =isDark ? Colors.white70 : Colors.black54;
                        final itemColor = selected ? selectedColor : unselectedColor;                        

                        return GestureDetector(
                          onTap: () {
                            controller.changeBottomTab(item.type);
                            if (item.type == BottomTabType.calls) Get.to(() => CallsScreen());
                            if (item.type == BottomTabType.chat) Get.offAll(() => HomeScreen());
                            if (item.type == BottomTabType.voicemail) Get.offAll(() => VoicemailScreen());
                            if (item.type == BottomTabType.profile) Get.to(() => ProfileScreen());
                            if (item.type == BottomTabType.updates) Get.to(() => UpdatesScreen());
                          },
                          behavior: HitTestBehavior.opaque,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (item.image != null)
                                  Image.asset(
                                    item.image!, width: selected ? 23 : 21, 
                                    height: selected ? 23 : 21,
                                    color: itemColor
                                  ),
                                const SizedBox(height: 2),
                                Text(
                                  item.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: itemColor,
                                    fontSize: 14,
                                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomItem {
  final String? image;
  final String title;
  final BottomTabType type;

  _BottomItem({this.image, required this.title, required this.type});
}



 
 

