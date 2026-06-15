import 'package:get/get.dart';
import '../model/profile_option_model.dart';
import 'package:flutter/material.dart';

enum InvisibleOption {
  always,
  never,
  specifyTime,
}

class UserProfileController extends GetxController {
  final Rx<InvisibleOption> invisibleOption = InvisibleOption.specifyTime.obs;

  final RxString invisibleFromDate = '26 oct 2023'.obs;
  final RxString invisibleToDate = '26 oct 2023'.obs;

  final RxList<ProfileOptionModel> options = <ProfileOptionModel>[].obs;
  final RxList<CommonGroupModel> groups = <CommonGroupModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileOptions();
    loadCommonGroups();
  }

  void loadProfileOptions() {
    options.assignAll([
      ProfileOptionModel(
        type: ProfileOptionType.invisible,
        title: 'Invisible',
        subtitle: 'Specify time',
        icon: Icons.notifications_off_outlined,
        actionType: ProfileOptionActionType.sheet,
        value: true,
      ),
      ProfileOptionModel(
        type: ProfileOptionType.hideMobileNumber,
        title: 'Hide mobile number',
        subtitle: 'Off',
        icon: Icons.call_outlined,
        actionType: ProfileOptionActionType.toggle,
        value: false,
      ),
      ProfileOptionModel(
        type: ProfileOptionType.mediaLinksDocs,
        title: 'Media, Links, Docs',
        subtitle: '24 items',
        icon: Icons.photo_library_outlined,
        actionType: ProfileOptionActionType.navigation,
      ),
      ProfileOptionModel(
        type: ProfileOptionType.callForwarding,
        title: 'Call forwarding',
        subtitle: 'Off',
        icon: Icons.phone_forwarded_outlined,
        actionType: ProfileOptionActionType.toggle,
        value: false,
      ),
      ProfileOptionModel(
        type: ProfileOptionType.callWaiting,
        title: 'Call waiting',
        subtitle: 'On',
        icon: Icons.phone_callback_outlined,
        actionType: ProfileOptionActionType.toggle,
        value: true,
      ),
      ProfileOptionModel(
        type: ProfileOptionType.voicemail,
        title: 'Voicemail',
        subtitle: 'Off',
        icon: Icons.voicemail_outlined,
        actionType: ProfileOptionActionType.toggle,
        value: false,
      ),
    ]);
  }

  void loadCommonGroups() {
    groups.assignAll([
      CommonGroupModel(
        id: '1',
        title: 'College friends',
        imageUrl: 'https://images.unsplash.com/photo-1529156069898-49953e39b3ac',
        membersCount: 12,
      ),
      CommonGroupModel(
        id: '2',
        title: 'Design Team',
        imageUrl: 'https://images.unsplash.com/photo-1522075469751-3a6694fb2f61',
        membersCount: 8,
      ),
    ]);
  }

  void toggleOption(ProfileOptionType type) {
    final index = options.indexWhere((e) => e.type == type);
    if (index == -1) return;

    final old = options[index];
    final newValue = !old.value;

    options[index] = old.copyWith(
      value: newValue,
      subtitle: newValue ? 'On' : 'Off',
    );
  }

  void updateInvisibleOption(InvisibleOption option) {
    invisibleOption.value = option;

    final index = options.indexWhere((e) => e.type == ProfileOptionType.invisible);
    if (index == -1) return;

    String subtitle;

    switch (option) {
      case InvisibleOption.always:
        subtitle = 'Always';
        break;
      case InvisibleOption.never:
        subtitle = 'Never';
        break;
      case InvisibleOption.specifyTime:
        subtitle = 'Specify time';
        break;
    }

    options[index] = options[index].copyWith(
      subtitle: subtitle,
      value: option != InvisibleOption.never,
    );
  }

  void updateDateRange({
    required String from,
    required String to,
  }) {
    invisibleFromDate.value = from;
    invisibleToDate.value = to;
  }
}


