import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/contact_controller.dart';
import 'widgets/contact_group_tile.dart';
import 'widgets/contact_setting_tile.dart';

class ContactDetailScreen extends StatelessWidget {
  ContactDetailScreen({super.key});

  final ContactController controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 20),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: Get.back,
                    child: Container(
                      height: 36,
                      width: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xFF202020),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),

                  const Spacer(),

                  TextButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      "Edit contact",
                      style: TextStyle(
                        color: Color(0xFF4D8DFF),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Container(
                height: 96,
                width: 96,
                decoration: const BoxDecoration(
                  color: Color(0xFF075A6B),
                  shape: BoxShape.circle,
                ),
                clipBehavior: Clip.antiAlias,
                child: Image.network(
                  controller.profileImage,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                controller.fullName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _InfoChip(text: controller.userHandle),
                  const SizedBox(width: 4),
                  _InfoChip(text: controller.mobileNumber),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  _RoundActionButton(icon: Icons.call_rounded),
                  SizedBox(width: 12),
                  _RoundActionButton(icon: Icons.videocam_rounded),
                  SizedBox(width: 12),
                  _RoundActionButton(icon: Icons.chat_bubble_outline_rounded),
                ],
              ),

              const SizedBox(height: 24),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: const [
                    Padding(
                      padding: EdgeInsets.fromLTRB(14, 14, 14, 4),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Groups in common",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    ContactGroupTile(
                      imageUrl:
                          "https://images.unsplash.com/photo-1529156069898-49953e39b3ac?w=400",
                      title: "College friends",
                    ),
                    ContactGroupTile(
                      imageUrl:
                          "https://images.unsplash.com/photo-1529333166437-7750a6dd5a70?w=400",
                      title: "Buddies",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF202020),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Column(
                  children: [
                    ContactSettingTile(
                      icon: Icons.phone_forwarded_rounded,
                      title: "Call forwarding",
                    ),
                    _DividerLine(),
                    ContactSettingTile(
                      icon: Icons.phone_callback_rounded,
                      title: "Call waiting",
                    ),
                    _DividerLine(),
                    ContactSettingTile(
                      icon: Icons.voicemail_rounded,
                      title: "Voicemail",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String text;

  const _InfoChip({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF303030),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _RoundActionButton extends StatelessWidget {
  final IconData icon;

  const _RoundActionButton({
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: const BoxDecoration(
        color: Color(0xFF303030),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 23,
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 48),
      child: Divider(
        height: 1,
        thickness: 0.6,
        color: Colors.white.withOpacity(0.06),
      ),
    );
  }
}


