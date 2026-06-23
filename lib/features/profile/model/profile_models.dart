import 'package:flutter/material.dart';

enum ProfileMenuType {
  account,
  privacy,
  notification,
  chats,
  list,
  language,
  inviteFriends,
  info,
}

enum SettingItemType {
  changeUserName,
  changeNumber,
  deleteAccount,
  removeAccount,
  lastSeenOnline,
  profilePhoto,
  about,
  status,
  posts,
  phoneNumber,
  groups,
  messageNotifications,
  groupNotifications,
  callNotifications,
  chatBackup,
  chatWallpaper,
  chatHistory,
}

class ProfileMenuModel {
  final ProfileMenuType type;
  final String title;
  final IconData icon;

  ProfileMenuModel({
    required this.type,
    required this.title,
    required this.icon,
  });
}

class SwitchUserModel {
  final String name;
  final String username;
  final String phone;
  final String avatar;
  final bool isCurrent;

  SwitchUserModel({
    required this.name,
    required this.username,
    required this.phone,
    required this.avatar,
    this.isCurrent = false,
  });
}

class SettingItemModel {
  final SettingItemType type;
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool isDanger;
  final VoidCallback? onTap;

  SettingItemModel({
    required this.type,
    required this.title,
    required this.icon,
    this.subtitle,
    this.isDanger = false,
    this.onTap,
  });
}


