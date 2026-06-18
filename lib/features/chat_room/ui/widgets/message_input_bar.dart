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
      // backgroundColor: Colors.transparent,
      // barrierColor: Colors.black.withOpacity(0.55),
      isScrollControlled: true,
      builder: (context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;

        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 56, 10, 22),
                child: ClipRRect(
                  // borderRadius: BorderRadius.circular(26),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(0, 26, 0, 24),
                      decoration: BoxDecoration(
                        // color: Colors.black.withOpacity(0.58),
                        borderRadius: BorderRadius.circular(21),
                        border: Border.all(color: Colors.white.withOpacity(0.08)),
                      ),
                      child: GridView.count(
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        childAspectRatio: 1.35,
                        children: [
                          _AttachmentItem(
                            icon: Icons.camera_alt_outlined,
                            label: 'Camera',
                            onTap: () {
                              Navigator.pop(context);
                              controller.pickImage(ImageSource.camera);
                            },
                          ),
                          _AttachmentItem(
                            icon: Icons.image_outlined,
                            label: 'Photos',
                            onTap: () {
                              Navigator.pop(context);
                              controller.pickImage(ImageSource.gallery);
                            },
                          ),
                          _AttachmentItem(
                            icon: Icons.graphic_eq_rounded,
                            label: 'Audio',
                            onTap: () {
                              Navigator.pop(context);
                              // controller.pickAudio();
                            },
                          ),
                          _AttachmentItem(
                            icon: Icons.description_outlined,
                            label: 'Documents',
                            onTap: () {
                              Navigator.pop(context);
                              controller.pickDocument();
                            },
                          ),
                          _AttachmentItem(
                            icon: Icons.graphic_eq_rounded,
                            label: 'Audio',
                            onTap: () {
                              Navigator.pop(context);
                              // controller.pickAudio();
                            },
                          ),
                          _AttachmentItem(
                            icon: Icons.image_outlined,
                            label: 'Photos',
                            onTap: () {
                              Navigator.pop(context);
                              controller.pickImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.26),
                          ),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ),
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
  final VoidCallback onTap;

  const _AttachmentItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: const Color(0xFF0A84FF).withOpacity(0.15),
        highlightColor: Colors.white.withOpacity(0.04),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.42),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF0A84FF),
                    size: 29,
                  ),

                  const SizedBox(height: 9),

                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

