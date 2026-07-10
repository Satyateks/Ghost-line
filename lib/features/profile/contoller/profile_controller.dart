
import 'package:get/get.dart';
import '../../../core/utils/app_assets.dart';
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
      ProfileMenuModel(type: ProfileMenuType.account, title: 'Account', icon: AppAssets.accountIcon),
      ProfileMenuModel(type: ProfileMenuType.privacy, title: 'Privacy', icon: AppAssets.privacyIcon),
      ProfileMenuModel(type: ProfileMenuType.notification, title: 'Notification', icon: AppAssets.notificationIcon),
      ProfileMenuModel(type: ProfileMenuType.chats, title: 'Chats', icon: AppAssets.commentIcon),
      ProfileMenuModel(type: ProfileMenuType.list, title: 'List', icon: AppAssets.listIcon),
      ProfileMenuModel(type: ProfileMenuType.language, title: 'Language', icon: AppAssets.languageIcon),
      ProfileMenuModel(type: ProfileMenuType.inviteFriends, title: 'Invite friends', icon: AppAssets.inviteIcon),
      ProfileMenuModel(type: ProfileMenuType.info, title: 'info', icon: AppAssets.infoIcon),
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
        icon: AppAssets.keysIcon,
      ),
      SettingItemModel(
        type: SettingItemType.changeNumber,
        title: 'Change number',
        subtitle: phone.value,
        icon: AppAssets.hashtagIcon,
      ),
      SettingItemModel(
        type: SettingItemType.deleteAccount,
        title: 'Delete account',
        subtitle: 'Permanently delete your account',
        icon: AppAssets.deleteIcon,
        isDanger: true,
      ),
      SettingItemModel(
        type: SettingItemType.removeAccount,
        title: 'Remove account',
        subtitle: 'Remove this account from this device',
        icon: AppAssets.removeUserIcon,
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
      ),
      SettingItemModel(
        type: SettingItemType.profilePhoto,
        title: 'Profile photo',
        subtitle: 'Everyone',
      ),
      SettingItemModel(
        type: SettingItemType.about,
        title: 'About',
        subtitle: 'My contacts',
      ),
      SettingItemModel(
        type: SettingItemType.status,
        title: 'Status',
        subtitle: 'My contacts except...',
        icon: AppAssets.deleteIcon,
      ),
      SettingItemModel(
        type: SettingItemType.posts,
        title: 'Posts',
        subtitle: 'Everyone',
        icon: AppAssets.deleteIcon,
      ),
      SettingItemModel(
        type: SettingItemType.phoneNumber,
        title: 'Phone number',
        subtitle: 'Nobody',
        icon: AppAssets.deleteIcon,
      ),
      SettingItemModel(
        type: SettingItemType.groups,
        title: 'Groups',
        subtitle: 'My contacts',
        icon: AppAssets.deleteIcon,
      ),
    ];
  }

  List<SettingItemModel> notificationItems() {
    return [
      SettingItemModel(
        type: SettingItemType.messageNotifications,
        title: 'Message notifications',
        subtitle: 'Tone, vibration, popup',
      ),
      SettingItemModel(
        type: SettingItemType.groupNotifications,
        title: 'Group notifications',
        subtitle: 'Tone, vibration',
      ),
      SettingItemModel(
        type: SettingItemType.callNotifications,
        title: 'Call notifications',
        subtitle: 'Ringtone',
      ),
    ];
  }

  List<SettingItemModel> chatItems() {
    return [
      SettingItemModel(type: SettingItemType.chatBackup, title: 'Chat backup'),
      SettingItemModel( type: SettingItemType.chatWallpaper, title: 'Export chat',),
      SettingItemModel(type: SettingItemType.chatHistory, title: 'Clear all chat',isDanger: true),
      SettingItemModel(type: SettingItemType.chatHistory, title: 'Delete all chat',isDanger: true),
    ];
  }
}

