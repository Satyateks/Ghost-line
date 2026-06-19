import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/avatar_widget.dart';
import '../../home/controller/home_controller.dart';
import '../../home/model/chat_item_model.dart';

class ForwardMessageScreen extends StatelessWidget {
  final dynamic message;

  ForwardMessageScreen({
    super.key,
    required this.message,
  });

  final HomeController homeController = Get.find<HomeController>();
  final TextEditingController searchController = TextEditingController();

  final RxString searchQuery = "".obs;
  final RxList<String> selectedChatIds = <String>[].obs;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 10, 8, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 34,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.10)
                            : Colors.black.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.08)
                              : Colors.black.withOpacity(0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: isDark ? Colors.white : Colors.black,
                            size: 15,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            "Chat to",
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 12.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 12),
              child: Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.11)
                      : Colors.black.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.08)
                        : Colors.black.withOpacity(0.06),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      color: isDark ? Colors.white54 : Colors.black45,
                      size: 20,
                    ),

                    const SizedBox(width: 8),

                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          searchQuery.value = value.trim().toLowerCase();
                        },
                        cursorColor: AppColors.buttonBlue,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black,
                          fontSize: 13,
                        ),
                        decoration: InputDecoration(
                          hintText: "Search name, numbers",
                          hintStyle: TextStyle(
                            color: isDark ? Colors.white54 : Colors.black45,
                            fontSize: 12.5,
                          ),
                          border: InputBorder.none,
                          isCollapsed: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Obx(() {
                final allChats = homeController.chats;

                final filteredChats = allChats.where((chat) {
                  final query = searchQuery.value;

                  if (query.isEmpty) return true;

                  return chat.name.toLowerCase().contains(query) || chat.message.toLowerCase().contains(query);
                }).toList();

                if (filteredChats.isEmpty) {
                  return const Center(
                    child: Text(
                      "No contacts found",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                    ),
                  );
                }

                final recentChats = filteredChats.take(4).toList();
                final contacts = filteredChats.skip(4).toList();

                return ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(8, 0, 10, 90),
                  children: [
                    if (recentChats.isNotEmpty) ...[
                      _ForwardSectionTitle(title: "Recents"),
                      ...recentChats.map(
                        (chat) => _ForwardContactTile(
                          chat: chat,
                          isSelected: selectedChatIds.contains(chat.id),
                          onTap: () {
                            _toggleSelected(chat.id);
                          },
                        ),
                      ),
                    ],

                    if (contacts.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      _ForwardSectionTitle(title: "Contacts"),
                      ...contacts.map(
                        (chat) => _ForwardContactTile(
                          chat: chat,
                          isSelected: selectedChatIds.contains(chat.id),
                          onTap: () {
                            _toggleSelected(chat.id);
                          },
                        ),
                      ),
                    ],
                  ],
                );
              }),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Obx(() {
        if (selectedChatIds.isEmpty) {
          return const SizedBox.shrink();
        }

        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
            child: ElevatedButton(
              onPressed: () {
                homeController.forwardMessage( message: message, chatIds: selectedChatIds);

                Get.back();

                Get.snackbar(
                  "Forwarded",
                  "Message forwarded successfully",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonBlue,
                elevation: 0,
                minimumSize: const Size.fromHeight(48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              child: Text(
                "Forward to ${selectedChatIds.length} chat",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  void _toggleSelected(String chatId) {
    if (selectedChatIds.contains(chatId)) selectedChatIds.remove(chatId);
    else selectedChatIds.add(chatId);

  }
}

class _ForwardSectionTitle extends StatelessWidget {
  final String title;

  const _ForwardSectionTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 8, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ForwardContactTile extends StatelessWidget {
  final ChatItemModel chat;
  final bool isSelected;
  final VoidCallback onTap;

  const _ForwardContactTile({
    required this.chat,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final phoneColor = isDark ? Colors.white70 : AppColors.lightTextSecondary;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.09)
                  : Colors.black.withOpacity(0.08),
              width: 0.7,
            ),
          ),
        ),
        child: Row(
          children: [
            Stack(
              children: [
                AvatarWidget(
                  name: chat.name,
                  imageUrl: chat.avatar,
                  size: 45,
                  isOnline: chat.isOnline,
                  showStatus: false,
                ),

                if (isSelected)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 18,
                      width: 18,
                      decoration: BoxDecoration(
                        color: AppColors.buttonBlue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? Colors.black : Colors.white,
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: nameColor,
                      fontSize: 14.5,
                      height: 1.05,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    chat.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: phoneColor,
                      fontSize: 13,
                      height: 1.05,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



