import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/theme_route.dart';
import '../../controller/chat_room_controller.dart';

class MessageInputBar extends StatelessWidget {
  final ChatRoomController controller;

  const MessageInputBar({
    super.key,
    required this.controller,
  });

  void _showAttachmentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: [
              _AttachmentItem(
                icon: Icons.camera_alt_rounded,
                label: 'Camera',
                color: Colors.blueAccent,
                onTap: () {
                  Navigator.pop(context);
                  controller.pickImage(ImageSource.camera);
                },
              ),
              _AttachmentItem(
                icon: Icons.photo_library_rounded,
                label: 'Photos',
                color: Colors.purpleAccent,
                onTap: () {
                  Navigator.pop(context);
                  controller.pickImage(ImageSource.gallery);
                },
              ),
              _AttachmentItem(
                icon: Icons.insert_drive_file_rounded,
                label: 'Document',
                color: Colors.orangeAccent,
                onTap: () {
                  Navigator.pop(context);
                  controller.pickDocument();
                },
              ),
              _AttachmentItem(
                icon: Icons.audiotrack_rounded,
                label: 'Audio',
                color: Colors.redAccent,
                onTap: () {
                  Navigator.pop(context);
                  // Optionally trigger file picker for audio specifically if needed,
                  // or just rely on the mic button for recording.
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
        child: Row(
          children: [
            _CircleActionButton(
              icon: Icons.add_rounded,
              onTap: () => _showAttachmentBottomSheet(context),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    height: 44,
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withOpacity(0.08)
                          : Colors.white.withOpacity(0.78),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.10)
                            : Colors.white.withOpacity(0.95),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.messageCtrl,
                            cursorColor: AppColors.buttonBlue,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Write your message',
                              hintStyle: TextStyle(
                                color: isDark ? Colors.white : Colors.black38,
                                fontSize: 13,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 11,
                              ),
                            ),
                            onSubmitted: (_) => controller.sendMessage(),
                          ),
                        ),
                        Obx(() {
                          if (controller.isTyping.value) {
                            return InkWell(
                              onTap: controller.sendMessage,
                              borderRadius: BorderRadius.circular(999),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(
                                  Icons.send_rounded,
                                  color: AppColors.buttonBlue,
                                  size: 23,
                                ),
                              ),
                            );
                          }
                          return Obx(() {
                            final isRecording = controller.isRecording.value;
                            return InkWell(
                              onTap: controller.toggleRecording,
                              borderRadius: BorderRadius.circular(999),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Icon(
                                  isRecording ? Icons.stop_circle_rounded : Icons.mic_none_rounded,
                                  color: isRecording ? Colors.red : textColor,
                                  size: 23,
                                ),
                              ),
                            );
                          });
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleActionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark
              ? Colors.white.withOpacity(0.08)
              : Colors.white.withOpacity(0.76),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.10)
                : Colors.white.withOpacity(0.95),
          ),
        ),
        child: Icon(
          icon,
          color: isDark ? Colors.white : AppColors.lightTextPrimary,
          size: 25,
        ),
      ),
    );
  }
}

class _AttachmentItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AttachmentItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.1),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}