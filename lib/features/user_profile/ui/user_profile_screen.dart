// ignore_for_file: unnecessary_underscores, deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../../core/widgets/avatar_widget.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../controller/user_profile_controller.dart';
import '../model/profile_option_model.dart';
import '../internal/media_links_docs/ui/media_links_docs_screen.dart';
import 'widgets/groups_common_card.dart';
import 'widgets/invisible_bottom_sheet.dart';
import 'widgets/profile_action_buttons.dart';
import 'widgets/profile_option_card.dart';
import 'widgets/option_tile_wrapper.dart';
import 'widgets/group_bottom_sheet.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key, required this.name, required this.avatar});

  final String name;
  final String avatar;

  final UserProfileController controller = Get.put(UserProfileController());

  late final groupOptions = controller.groupOptions;

  void _handleOptionTap(BuildContext context, ProfileOptionModel item) {
    switch (item.type) {
      case ProfileOptionType.invisible: InvisibleBottomSheet.show(context: context, controller: controller); break;
      case ProfileOptionType.hideMobileNumber:
      case ProfileOptionType.callForwarding:
      case ProfileOptionType.callWaiting:
      case ProfileOptionType.voicemail: controller.toggleOption(item.type); break;
      case ProfileOptionType.mediaLinksDocs: Get.to(() => MediaLinksDocsScreen(userName: name)); break;
    }
  }

  void _handleOptionTap1(BuildContext context, ProfileOptionModel item) {
    GroupBottomSheet.show(context: context, controller: controller);
  }

  void _handleToggle1(ProfileOptionModel item) {
    item.value.value = !item.value.value;
    item = item.copyWith(subtitle: item.value.value ? 'On' : 'Off');
  }

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      safeArea: false,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          BlurBackground(avatar: avatar),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 24),
              child: Column(
                children: [
                  TopBackChip(name: name),

                  const SizedBox(height: 34),

                  AvatarWidget(name: name, imageUrl: avatar, size: 128, showStatus: false),

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
                  const SizedBox(height: 14),
                  OptionsList(
                    options: groupOptions,
                    onTap: (item) { _handleOptionTap1(context, item); },
                    onToggle: (item) { _handleToggle1(item); },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionsList extends StatelessWidget {
  final List<ProfileOptionModel> options;
  final ValueChanged<ProfileOptionModel> onTap;
  final ValueChanged<ProfileOptionModel> onToggle;

  const OptionsList({
    super.key,
    required this.options,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.14) : Colors.white.withOpacity(0.78),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: isDark ? Colors.white.withOpacity(0.14) : Colors.white.withOpacity(0.95)),
          ),
          child: Column(
            children: List.generate(options.length, (index) {
              final option = options[index];

              return OptionTileWrapper(
                option: option,
                showDivider: index != options.length - 1,
                onTap: () => onTap(option),
                onToggle: (_) => onToggle(option),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class BlurBackground extends StatelessWidget {
  final String avatar;

  const BlurBackground({
    super.key,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(avatar, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox.shrink()),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 32, sigmaY: 32),
          child: Container(color: isDark ? Colors.black.withOpacity(0.82) : Colors.white.withOpacity(0.78))),
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

class TopBackChip extends StatelessWidget {
  final String name;

  const TopBackChip({
    super.key,
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
                color: isDark ? Colors.white.withOpacity(0.10) : Colors.white.withOpacity(0.72),
                borderRadius: BorderRadius.circular(999),
                border: Border.all( color: isDark ? Colors.white.withOpacity(0.14) : Colors.white.withOpacity(0.95), ),
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
                  Text(name, style: AppTextStyles.bodyHighLarge(isDark ? Colors.white : AppColors.lightTextPrimary,)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
