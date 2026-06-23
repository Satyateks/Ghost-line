import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/profile_models.dart';

class ProfileController extends GetxController {
  final RxString name = 'Satyam Mishra'.obs;
  final RxString username = '@satyamishra95391'.obs;
  final RxString phone = '+91 9565494959'.obs;
  final RxString avatar = 'https://images.unsplash.com/photo-1504593811423-6dd665756598'.obs;

  final RxList<ProfileMenuModel> menus = <ProfileMenuModel>[].obs;
  final RxList<SwitchUserModel> switchUsers = <SwitchUserModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadMenus();
    _loadSwitchUsers();
  }

  void _loadMenus() {
    menus.assignAll([
      ProfileMenuModel(
        type: ProfileMenuType.account,
        title: 'Account',
        icon: Icons.person_outline_rounded,
      ),
      ProfileMenuModel(
        type: ProfileMenuType.privacy,
        title: 'Privacy',
        icon: Icons.privacy_tip_outlined,
      ),
      ProfileMenuModel(
        type: ProfileMenuType.notification,
        title: 'Notification',
        icon: Icons.notifications_none_rounded,
      ),
      ProfileMenuModel(
        type: ProfileMenuType.chats,
        title: 'Chats',
        icon: Icons.chat_bubble_outline_rounded,
      ),
      ProfileMenuModel(
        type: ProfileMenuType.list,
        title: 'List',
        icon: Icons.list_alt_rounded,
      ),
      ProfileMenuModel(
        type: ProfileMenuType.language,
        title: 'Language',
        icon: Icons.translate_rounded,
      ),
      ProfileMenuModel(
        type: ProfileMenuType.inviteFriends,
        title: 'Invite friends',
        icon: Icons.groups_2_outlined,
      ),
      ProfileMenuModel(
        type: ProfileMenuType.info,
        title: 'info',
        icon: Icons.info_outline_rounded,
      ),
    ]);
  }

  void _loadSwitchUsers() {
    switchUsers.assignAll([
      SwitchUserModel(
        name: 'Sneha Singh',
        username: '@sneha_singh',
        phone: '+91 9876543210',
        avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
      ),
      SwitchUserModel(
        name: 'Satyam Mishra',
        username: '@Satyammish1',
        phone: '+91 9565494959',
        avatar: 'https://images.unsplash.com/photo-1504593811423-6dd665756598',
        isCurrent: true,
      ),
      SwitchUserModel(
        name: 'Sejal Pawar',
        username: '@sjal_singh',
        phone: '+91 9876523210',
        avatar: 'https://images.unsplash.com/photo-1488426862026-3ee34a7d66df',
      ),
    ]);
  }

  void switchAccount(SwitchUserModel user) {
    name.value = user.name;
    username.value = user.username;
    phone.value = user.phone;
    avatar.value = user.avatar;

    switchUsers.value = switchUsers.map((e) {
      return SwitchUserModel(
        name: e.name,
        username: e.username,
        phone: e.phone,
        avatar: e.avatar,
        isCurrent: e.username == user.username,
      );
    }).toList();
  }

  List<SettingItemModel> accountItems() {
    return [
      SettingItemModel(
        type: SettingItemType.changeUserName,
        title: 'Change user name',
        subtitle: username.value,
        icon: Icons.person_outline_rounded,
      ),
      SettingItemModel(
        type: SettingItemType.changeNumber,
        title: 'Change number',
        subtitle: phone.value,
        icon: Icons.call_outlined,
      ),
      SettingItemModel(
        type: SettingItemType.deleteAccount,
        title: 'Delete account',
        subtitle: 'Permanently delete your account',
        icon: Icons.delete_outline_rounded,
        isDanger: true,
      ),
      SettingItemModel(
        type: SettingItemType.removeAccount,
        title: 'Remove account',
        subtitle: 'Remove this account from this device',
        icon: Icons.logout_rounded,
        isDanger: true,
      ),
    ];
  }

  List<SettingItemModel> privacyItems() {
    return [
      SettingItemModel(
        type: SettingItemType.lastSeenOnline,
        title: 'Last seen and online',
        subtitle: 'Nobody',
        icon: Icons.access_time_rounded,
      ),
      SettingItemModel(
        type: SettingItemType.profilePhoto,
        title: 'Profile photo',
        subtitle: 'Everyone',
        icon: Icons.photo_camera_outlined,
      ),
      SettingItemModel(
        type: SettingItemType.about,
        title: 'About',
        subtitle: 'My contacts',
        icon: Icons.info_outline_rounded,
      ),
      SettingItemModel(
        type: SettingItemType.status,
        title: 'Status',
        subtitle: 'My contacts except...',
        icon: Icons.circle_outlined,
      ),
      SettingItemModel(
        type: SettingItemType.posts,
        title: 'Posts',
        subtitle: 'Everyone',
        icon: Icons.dynamic_feed_outlined,
      ),
      SettingItemModel(
        type: SettingItemType.phoneNumber,
        title: 'Phone number',
        subtitle: 'Nobody',
        icon: Icons.call_outlined,
      ),
      SettingItemModel(
        type: SettingItemType.groups,
        title: 'Groups',
        subtitle: 'My contacts',
        icon: Icons.groups_2_outlined,
      ),
    ];
  }

  List<SettingItemModel> notificationItems() {
    return [
      SettingItemModel(
        type: SettingItemType.messageNotifications,
        title: 'Message notifications',
        subtitle: 'Tone, vibration, popup',
        icon: Icons.notifications_none_rounded,
      ),
      SettingItemModel(
        type: SettingItemType.groupNotifications,
        title: 'Group notifications',
        subtitle: 'Tone, vibration',
        icon: Icons.groups_2_outlined,
      ),
      SettingItemModel(
        type: SettingItemType.callNotifications,
        title: 'Call notifications',
        subtitle: 'Ringtone',
        icon: Icons.call_outlined,
      ),
    ];
  }

  List<SettingItemModel> chatItems() {
    return [
      SettingItemModel(
        type: SettingItemType.chatBackup,
        title: 'Chat backup',
        subtitle: 'Back up your messages',
        icon: Icons.cloud_upload_outlined,
      ),
      SettingItemModel(
        type: SettingItemType.chatWallpaper,
        title: 'Chat wallpaper',
        subtitle: 'Change chat background',
        icon: Icons.wallpaper_outlined,
      ),
      SettingItemModel(
        type: SettingItemType.chatHistory,
        title: 'Chat history',
        subtitle: 'Export, clear or delete chats',
        icon: Icons.history_rounded,
      ),
    ];
  }
}

