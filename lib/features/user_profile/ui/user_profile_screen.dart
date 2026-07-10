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
      case ProfileOptionType.invisible:
        InvisibleBottomSheet.show(context: context, controller: controller);
        break;
      case ProfileOptionType.hideMobileNumber:
      case ProfileOptionType.callForwarding:
      case ProfileOptionType.callWaiting:
      case ProfileOptionType.voicemail:
        controller.toggleOption(item.type);
        break;
      case ProfileOptionType.mediaLinksDocs:
        Get.to(() => MediaLinksDocsScreen(userName: name));
        break;
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
          // ── Layered Blur Background ─────────────────────────────────────
          _GlassBg(avatar: avatar),

          // ── Scrollable Content ─────────────────────────────────────────
          SafeArea(
            bottom: false,
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Back button bar
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                    child: _TopBar(name: name),
                  ),
                ),

                // Hero profile card (avatar + name + status)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 28, 16, 0),
                    child: _HeroProfileCard(name: name, avatar: avatar),
                  ),
                ),

                // Action buttons
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 22, 16, 0),
                    child: ProfileActionButtons(),
                  ),
                ),

                // Info strip (phone, status badge)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                    child: _InfoStrip(),
                  ),
                ),

                // Options card
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                    child: ProfileOptionCard(
                      options: controller.options,
                      onTap: (item) => _handleOptionTap(context, item),
                      onToggle: (item) => controller.toggleOption(item.type),
                    ),
                  ),
                ),

                // Groups in common
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: GroupsCommonCard(
                      groups: controller.groups,
                      onTap: (group) => SnackbarHelper.success(
                        '${group.title} opened',
                        title: 'Group',
                      ),
                    ),
                  ),
                ),

                // Group options
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
                    child: OptionsList(
                      options: groupOptions,
                      onTap: (item) => _handleOptionTap1(context, item),
                      onToggle: (item) => _handleToggle1(item),
                    ),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 40)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LAYERED GLASS BACKGROUND
// Background mein avatar image blur hokar dikhti rehti hai throughout the screen
// ─────────────────────────────────────────────────────────────────────────────
class _GlassBg extends StatelessWidget {
  final String avatar;
  const _GlassBg({required this.avatar});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Stack(
      fit: StackFit.expand,
      children: [
        // Raw avatar image as base layer – yahi "backscreen data" hai jo
        // glass ke peeche se blurred form mein dikhta rehta hai
        Image.network(
          avatar,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            decoration: BoxDecoration(
              gradient: isDark
                  ? const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF0F0C29),
                        Color(0xFF302B63),
                        Color(0xFF24243E),
                      ],
                    )
                  : const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFE0E8FF),
                        Color(0xFFC8D8F8),
                        Color(0xFFEEF2FF),
                      ],
                    ),
            ),
          ),
        ),

        // Heavy blur so the image is visible but dreamy
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
          child: const SizedBox.expand(),
        ),

        // Dark/light tint overlay
        Container(
          decoration: BoxDecoration(
            gradient: isDark
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.55),
                      Colors.black.withOpacity(0.72),
                      Colors.black.withOpacity(0.88),
                    ],
                  )
                : LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.45),
                      AppColors.primarybgsLight.withOpacity(0.68),
                      AppColors.primarybgsLight.withOpacity(0.88),
                    ],
                  ),
          ),
        ),

        // Subtle colour accent blobs to add depth
        Positioned(
          top: -80,
          left: -60,
          child: _GlowBlob(
            color: isDark
                ? AppColors.primaryPurple.withOpacity(0.22)
                : AppColors.primaryBlue.withOpacity(0.10),
            radius: 220,
          ),
        ),
        Positioned(
          bottom: 60,
          right: -80,
          child: _GlowBlob(
            color: isDark
                ? AppColors.primaryBlue.withOpacity(0.18)
                : AppColors.primaryPurple.withOpacity(0.08),
            radius: 260,
          ),
        ),
      ],
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  final double radius;
  const _GlowBlob({required this.color, required this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// TOP BAR (Back button)
// ─────────────────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final String name;
  const _TopBar({required this.name});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Row(
      children: [
        // Glass back pill
        InkWell(
          onTap: Get.back,
          borderRadius: BorderRadius.circular(999),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                height: 46,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.10)
                      : Colors.white.withOpacity(0.68),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.18)
                        : Colors.white.withOpacity(0.95),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      name,
                      style: AppTextStyles.bodyHighLarge(
                        isDark ? Colors.white : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HERO PROFILE CARD
// Avatar + Name + Online badge — largest glass panel on screen
// ─────────────────────────────────────────────────────────────────────────────
class _HeroProfileCard extends StatelessWidget {
  final String name;
  final String avatar;
  const _HeroProfileCard({required this.name, required this.avatar});

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.52),
            borderRadius: BorderRadius.circular(36),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.16)
                  : Colors.white.withOpacity(0.95),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.28)
                    : Colors.black.withOpacity(0.07),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              // Avatar with glow ring
              Stack(
                alignment: Alignment.center,
                children: [
                  // Outer glow ring
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryBlue.withOpacity(0.55),
                          AppColors.primaryPurple.withOpacity(0.55),
                        ],
                      ),
                    ),
                  ),
                  // Inner gap
                  Container(
                    width: 132,
                    height: 132,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isDark
                          ? Colors.black.withOpacity(0.30)
                          : Colors.white.withOpacity(0.30),
                    ),
                  ),
                  AvatarWidget(
                    name: name,
                    imageUrl: avatar,
                    size: 124,
                    showStatus: false,
                  ),
                  // Online dot
                  Positioned(
                    right: 10,
                    bottom: 8,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: AppColors.online,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? Colors.black : Colors.white,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.online.withOpacity(0.6),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Name
              Text(
                name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ),

              const SizedBox(height: 8),

              // Online status pill
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.online.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: AppColors.online.withOpacity(0.38),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: const BoxDecoration(
                            color: AppColors.online,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Online',
                          style: TextStyle(
                            color: isDark
                                ? AppColors.online
                                : const Color(0xFF15803D),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// INFO STRIP  (phone number · muted · block chips)
// ─────────────────────────────────────────────────────────────────────────────
class _InfoStrip extends StatelessWidget {
  const _InfoStrip();

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.55),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.14)
                  : Colors.white.withOpacity(0.90),
            ),
          ),
          child: Row(
            children: [
              _InfoChip(
                icon: Icons.phone_outlined,
                label: '+91 98765 43210',
                isDark: isDark,
                color: AppColors.primaryBlue,
              ),
              const SizedBox(width: 10),
              _InfoChip(
                icon: Icons.notifications_off_outlined,
                label: 'Mute',
                isDark: isDark,
                color: AppColors.warning,
              ),
              const SizedBox(width: 10),
              _InfoChip(
                icon: Icons.block_rounded,
                label: 'Block',
                isDark: isDark,
                color: AppColors.error,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Color color;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: color.withOpacity(isDark ? 0.14 : 0.09),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: color.withOpacity(0.22)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 20, color: color),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 10.5,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// OPTIONS LIST  (group options)
// ─────────────────────────────────────────────────────────────────────────────
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
            color: isDark
                ? Colors.white.withOpacity(0.08)
                : Colors.white.withOpacity(0.55),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.14)
                  : Colors.white.withOpacity(0.95),
            ),
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
