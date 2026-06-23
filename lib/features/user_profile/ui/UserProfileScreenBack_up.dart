/*
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/theme_route.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../../core/widgets/widgets_route.dart';
import '../controller/user_profile_controller.dart';
import '../internal/media_links_docs/ui/media_links_docs_screen.dart';
import '../model/profile_option_model.dart';
import 'widgets/groups_common_card.dart';
import 'widgets/invisible_bottom_sheet.dart';
import 'widgets/profile_action_buttons.dart';
import 'widgets/profile_option_card.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key, required this.name, required this.avatar});

  final String name;
  final String avatar;

  final UserProfileController controller = Get.put(UserProfileController());

  void _handleOptionTap( BuildContext context, ProfileOptionModel item) {
    switch (item.type) {
      case ProfileOptionType.invisible: InvisibleBottomSheet.show(context: context, controller: controller); break;
      case ProfileOptionType.hideMobileNumber:
      case ProfileOptionType.callForwarding:
      case ProfileOptionType.callWaiting:
      case ProfileOptionType.voicemail: controller.toggleOption(item.type); break;
      case ProfileOptionType.mediaLinksDocs: Get.to( () => MediaLinksDocsScreen(userName: name)); break;
    }
  }


  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      safeArea: false,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          _BlurBackground( avatar: avatar ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 24),
              child: Column(
                children: [
                  _TopBackChip(name: name),

                  const SizedBox(height: 34),

                  AvatarWidget(
                    name: name,
                    imageUrl: avatar,
                    size: 128,
                    showStatus: false,
                  ),

                  const SizedBox(height: 18),

                  Text(
                    name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.isDarkMode ? Colors.white : AppColors.lightTextPrimary,
                      fontSize: 28,
                      height: 1.05,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.6,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const ProfileActionButtons(),

                  const SizedBox(height: 40),

                  ProfileOptionCard(
                      options: controller.options,
                      onTap: (item) { _handleOptionTap(context, item); },
                      onToggle: (item) { controller.toggleOption(item.type); },
                    ),

                  const SizedBox(height: 14),
                  GroupsCommonCard(groups: controller.groups, onTap: (group) {SnackbarHelper.success('${group.title} opened', title: 'Group');}),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  
}

class _BlurBackground extends StatelessWidget {
  final String avatar;

  const _BlurBackground({
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          avatar,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const SizedBox.shrink(),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
          child: Container(
            color: isDark
                ? Colors.black.withOpacity(0.82)
                : Colors.white.withOpacity(0.78),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.70),
                      Colors.black.withOpacity(0.88),
                      Colors.black,
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.70),
                      AppColors.lightBg.withOpacity(0.92),
                      AppColors.lightBg,
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}

class _TopBackChip extends StatelessWidget {
  final String name;

  const _TopBackChip({
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        onTap: Get.back,
        borderRadius: BorderRadius.circular(999),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.10)
                    : Colors.white.withOpacity(0.72),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withOpacity(0.14)
                      : Colors.white.withOpacity(0.95),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 17,
                    color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    name,
                    style: TextStyle(
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
*/

