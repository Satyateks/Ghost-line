// ignore_for_file: unnecessary_underscores

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/glass_scaffold.dart';
import '../../chat_room/ui/chat_room_screen.dart';
import '../controller/home_controller.dart';

import 'widgets/home_search_bar.dart';
import 'widgets/chat_filter_tabs.dart';
import 'widgets/chat_list_tile.dart';
import 'widgets/main_bottom_nav.dart';
import 'widgets/delete_chat_sheet.dart';
import 'widgets/home_top_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      safeArea: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: MainBottomNav(controller: controller),
      body: Column(
        children: [
          const SizedBox(height: 8),

          const HomeTopBar(),

          const SizedBox(height: 10),

          HomeSearchBar(onChanged: controller.updateSearch),

          const SizedBox(height: 10),

          ChatFilterTabs(controller: controller),

          const SizedBox(height: 8),

          Expanded(
            child: Obx(() {
              final chats = controller.filteredChats;

              if (chats.isEmpty) return const _EmptyChatList();


              return ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 4, 10, 100),
                itemCount: chats.length,
                separatorBuilder: (_, __) => Divider(height: 1, thickness: 0.1, color: Theme.of(context).dividerColor, indent: 62),
                itemBuilder: (context, index) {
                  final chat = chats[index];

                  return ChatListTile(
                    chat: chat,
                    onTap: ()=> Get.to(() => ChatRoomScreen(name: chat.name, avatar: chat.avatar)),
                    onLongPress: () {
                      DeleteChatSheet.show(
                        context: context,
                        onDelete: () {
                          controller.deleteChat(chat.id);
                          Get.back();
                        },
                      );
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _EmptyChatList extends StatelessWidget {
  const _EmptyChatList();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.chat_bubble_outline_rounded,
              size: 72,
              color: isDark
                  ? Colors.white.withOpacity(0.25)
                  : Colors.black.withOpacity(0.25),
            ),
            const SizedBox(height: 20),
            Text(
              'No chats yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Start a new conversation and your chats will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: isDark ? Colors.white54 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


