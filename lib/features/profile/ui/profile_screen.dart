import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghostline/core/utils/snackbar_helper.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../home/controller/home_controller.dart';
import '../../home/ui/widgets/main_bottom_nav.dart';
import '../contoller/profile_controller.dart';
import '../model/profile_models.dart';
import 'common_settings_screen.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/profile_menu_card.dart';
import 'widgets/profile_plan_card.dart';
import 'widgets/setting_action_sheet.dart';
import 'widgets/switch_account_sheet.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());
  final HomeController homeCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeCtrl.selectedBottomTab.value = BottomTabType.profile;

    return GlassScaffold(
      safeArea: true,
      bottomNavigationBar: MainBottomNav(controller: homeCtrl),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(14, 20, 14, 110),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.lightTextPrimary,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
            ),

            const SizedBox(height: 30),

            ProfileHeaderCard(
                name: controller.name.value,
                username: controller.username.value,
                phone: controller.phone.value,
                avatar: controller.avatar.value,
                onSwitch: () {
                  SwitchAccountSheet.show(
                    context: context,
                    users: controller.switchUsers,
                    onSelect: (user) {
                      controller.switchAccount(user);
                      Get.back();
                    },
                  );
                },

            ),

            const SizedBox(height: 12),

           ProfileMenuCard(
                menus: controller.menus,
                onTap: (menu) => _handleMenuTap(menu),
                onLogout: () {SnackbarHelper.error('Logout action clicked');
                },
              ),

            const SizedBox(height: 12),

            const ProfilePlanCard(),
          ],
        ),
      ),
    );
  }

  void _handleMenuTap(ProfileMenuModel menu) {
    switch (menu.type) {
      case ProfileMenuType.account:
        Get.to(() => AccountSettingsScreen());
        break;

      case ProfileMenuType.privacy:
        Get.to(() => CommonSettingsScreen(title: 'Privacy', items: controller.privacyItems()));
        break;

      case ProfileMenuType.notification:
        Get.to(
          () => CommonSettingsScreen( title: 'Notification', items: controller.notificationItems()),
        );
        break;

      case ProfileMenuType.chats:
        Get.to(
          () => CommonSettingsScreen(
            title: 'Chats',
            items: controller.chatItems(),
          ),
        );
        break;

      case ProfileMenuType.list:
      case ProfileMenuType.language:
      case ProfileMenuType.inviteFriends:
      case ProfileMenuType.info:
        Get.to(
          () => CommonSettingsScreen(
            title: menu.title,
            items: [
              SettingItemModel(
                type: SettingItemType.about,
                title: '${menu.title} settings',
                subtitle: 'Manage ${menu.title.toLowerCase()} preferences',
                icon: menu.icon,
              ),
            ],
          ),
        );
        break;
    }
  }
}