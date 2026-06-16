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
    final items = [
      _BottomItem(image: AppAssets.callIcon, title: 'Calls', type: BottomTabType.calls),
      _BottomItem(image: AppAssets.commentIcons, title: 'Chat', type: BottomTabType.chat),
      _BottomItem(image: AppAssets.voicemailIcon, title: 'Voicemail', type: BottomTabType.voicemail),
      _BottomItem(image: AppAssets.updateIcon,title: 'Updates', type: BottomTabType.updates),
      _BottomItem(image: AppAssets.userIcon, title: 'Profile', type: BottomTabType.profile),
    ];

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 62,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white.withOpacity(0.075)
                    : Colors.white.withOpacity(0.78),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(0.12)
                      : Colors.white.withOpacity(0.95),
                ),
              ),
              child: Row(
                children: items.map((item) {
                  return Expanded(
                    child: Obx(() {
                      final selected = controller.selectedBottomTab.value == item.type;

                      return GestureDetector(
                        // onTap: () => controller.changeBottomTab(item.type),
                        onTap: () { controller.changeBottomTab(item.type);
                            if (item.type == BottomTabType.calls) Get.to(() => CallsScreen());
                            if (item.type == BottomTabType.chat) Get.offAll(() => HomeScreen());
                            if (item.type == BottomTabType.voicemail) Get.offAll(() => VoicemailScreen());
                            if (item.type == BottomTabType.profile) Get.to(() => ProfileScreen()); 
                            if (item.type == BottomTabType.updates) Get.to(() => UpdatesScreen()); 
                          },
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Image.asset(
                                  item.image!,
                                  width: 21,
                                  height: 21,
                                  color: selected
                                      ? AppColors.buttonBlue
                                      : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54,
                                ),
                              const SizedBox(height: 3),
                              Text(
                                item.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: selected
                                      ? AppColors.buttonBlue
                                      : Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.black54,
                                  fontSize: 10.5,
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
    );
  }
}

class _BottomItem {
  final String? image;
  final String title;
  final BottomTabType type;

  _BottomItem({this.image, required this.title, required this.type});
}

