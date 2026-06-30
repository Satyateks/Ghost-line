import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../core/theme/app_colors.dart';
import '../../../core/utils/snackbar_helper.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../home/controller/home_controller.dart';
import '../../home/ui/widgets/main_bottom_nav.dart';
import '../contoller/profile_controller.dart';
import '../model/profile_models.dart';
import 'common_settings_screen.dart';
import 'widgets/invite_friend.dart';
import 'widgets/language.dart';
import 'widgets/profile_header_card.dart';
import 'widgets/profile_menu_card.dart';
import 'widgets/profile_plan_card.dart';
import 'widgets/setting_action_sheet.dart';
import 'widgets/switch_account_sheet.dart';
import 'widgets/terms_condition.dart';
import 'widgets/privacy_policy.dart';
import 'widgets/app_info.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController controller = Get.put(ProfileController());
  final HomeController homeCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeCtrl.selectedBottomTab.value = BottomTabType.profile;

    return GlassScaffold(
      safeArea: true,resizeToAvoidBottomInset: true,
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
                fontWeight: FontWeight.bold,
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
      case ProfileMenuType.account: Get.to(() => AccountSettingsScreen()); break;

      case ProfileMenuType.privacy: Get.to(() => CommonSettingsScreen(title: 'Privacy', items: controller.privacyItems())); break;

      case ProfileMenuType.notification: Get.to( () => CommonSettingsScreen( title: 'Notification', items: controller.notificationItems()), ); break;

      case ProfileMenuType.chats: Get.to( () => CommonSettingsScreen( title: 'Chats', items: controller.chatItems(), ), ); break;

      case ProfileMenuType.info:
        Get.to(
          () => CommonSettingsScreen(
            title: menu.title,
            items: [
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Terms & Conditions',
                subtitle: 'Read our terms and conditions',
                icon: Icons.description_outlined,
                onTap: () => Get.to(() => const TermsConditionPage()),
              ),
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Privacy Policy',
                subtitle: 'Read our privacy policy',
                icon: Icons.privacy_tip_outlined,
                onTap: () => Get.to(() => const PrivacyPolicyPage()),
              ),
              SettingItemModel(
                type: SettingItemType.about,
                title: 'App Info',
                subtitle: 'Version 1.0.0',
                icon: Icons.info_outline,
                onTap: () => Get.to(() => const AppInfoPage()),
              ),
            ],
          ),
        );
        break;

      case ProfileMenuType.list:
        Get.to(
          () => CommonSettingsScreen(
            title: menu.title,
            items: [
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Family',
                subtitle: 'Mom, Dad, Sis and 4 others',
                icon: Icons.family_restroom_outlined,
                onTap: () => Get.to(() => const TermsConditionPage()),
              ),
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Unread',
                subtitle: '3 new messages from recent chats', 
                icon: Icons.mark_chat_unread_outlined,
                onTap: () => Get.to(() => const PrivacyPolicyPage()),
              ),
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Groups',
                subtitle: 'Design Team, Weekend Plans, Tech Talk', 
                icon: Icons.groups_outlined,
                onTap: () => Get.to(() => const AppInfoPage()),
              ),
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Favorites',
                subtitle: 'Starred contacts and pinned chats',
                icon: Icons.star_border_rounded,
                onTap: () => Get.to(() => const AppInfoPage()),
              ),
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Friends',
                subtitle: 'Rahul, Amit, Priya and 12 more',
                icon: Icons.people_alt_outlined,
                onTap: () => Get.to(() => const AppInfoPage()),
              ),
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Office',
                subtitle: 'Manager, HR, QA Team and 8 others',
                icon: Icons.business_center_outlined,
                onTap: () => Get.to(() => const AppInfoPage()),
              ),
              SettingItemModel(
                type: SettingItemType.about,
                title: 'Calls',
                subtitle: '2 missed calls • Yesterday, 10:45 PM',
                icon: Icons.phone_in_talk_outlined,
                onTap: () => Get.to(() => const AppInfoPage()),
              ),
            ],
          ),
        );
        break;
      case ProfileMenuType.inviteFriends:
      Get.to( () => InviteFriend());break;
      case ProfileMenuType.language: Get.to( () => LanguageScreen() ); break;
        // Get.to( () => 
        // CommonSettingsScreen(title: menu.title,
        //     items: [
        //       SettingItemModel(
        //         type: SettingItemType.about,
        //         title: '${menu.title} settings',
        //         subtitle: 'Manage ${menu.title.toLowerCase()} preferences',
        //         icon: menu.icon),
        //     ],
        //   ),
        // );
        // break;
    }
  }
}
