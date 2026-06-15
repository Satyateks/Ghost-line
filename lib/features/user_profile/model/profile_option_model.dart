import 'package:flutter/material.dart';

enum ProfileOptionType {
  invisible,
  hideMobileNumber,
  mediaLinksDocs,
  callForwarding,
  callWaiting,
  voicemail,
}

enum ProfileOptionActionType {
  sheet,
  toggle,
  navigation,
}

class ProfileOptionModel {
  final ProfileOptionType type;
  final String title;
  final String? subtitle;
  final IconData icon;
  final ProfileOptionActionType actionType;
  final bool value;

  ProfileOptionModel({
    required this.type,
    required this.title,
    required this.icon,
    required this.actionType,
    this.subtitle,
    this.value = false,
  });

  ProfileOptionModel copyWith({
    String? title,
    String? subtitle,
    IconData? icon,
    ProfileOptionActionType? actionType,
    bool? value,
  }) {
    return ProfileOptionModel(
      type: type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      icon: icon ?? this.icon,
      actionType: actionType ?? this.actionType,
      value: value ?? this.value,
    );
  }
}

class CommonGroupModel {
  final String id;
  final String title;
  final String imageUrl;
  final int membersCount;

  CommonGroupModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.membersCount = 0,
  });
}

