import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../core/theme/theme_route.dart';
import '../../../../core/widgets/widgets_route.dart';
import '../../model/chat_item_model.dart';


class ChatListTile extends StatelessWidget {
  final ChatItemModel chat;
  final VoidCallback onTap;
  final GestureLongPressStartCallback? onLongPressStart;

  const ChatListTile({
    super.key,
    required this.chat,
    required this.onTap,
    required this.onLongPressStart,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final msgColor = isDark ? Colors.white70 : AppColors.lightTextSecondary;
    final timeColor = isDark ? Colors.white60 : AppColors.lightTextMuted;

    return GestureDetector(
      onLongPressStart: onLongPressStart,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
          child: Row(
            children: [
            AvatarWidget(
              name: chat.name,
              imageUrl: chat.avatar,
              size: 56,
              isOnline: chat.isOnline,
              showStatus: false,
            ),

            const SizedBox(width: 8),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Row(
                  children: [
                    Expanded(child: Text(chat.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: AppTextStyles.bodyHighLarge(nameColor))),

                    if (chat.isMuted) ...[
                      const SizedBox(width: 5),
                      Icon(
                        Icons.notifications_off_outlined,
                        size: 14,
                        color: timeColor,
                      ),
                    ],

                    if (chat.isBlocked) ...[
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.block_rounded,
                        size: 14,
                        color: Colors.redAccent,
                      ),
                    ],
                  ],
                ),
                  const SizedBox(height: 4),
                  Text(chat.message, maxLines: 2, overflow: TextOverflow.ellipsis, style: AppTextStyles.bodyLarge(msgColor)),
                ],
              ),
            ),

            const SizedBox(width: 8),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(chat.time,style: AppTextStyles.bodyMedium(timeColor)),
                const SizedBox(height: 8),
                      
                if (chat.unreadCount > 0)
                  Container(
                    height: 24,
                    constraints: const BoxConstraints(minWidth: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(color: AppColors.buttonBlue, shape: BoxShape.circle),
                    child: Text(chat.unreadCount.toString(),style: AppTextStyles.bodyMedium(Colors.white)),
                  )
                else
                  const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}


class ChatActionMenu {
  static Future<void> show({
    required BuildContext context,
    required LongPressStartDetails details,
    required ChatItemModel chat,
    required VoidCallback onArchive,
    required VoidCallback onMute,
    required VoidCallback onFavourite,
    required VoidCallback onAddToList,
    required VoidCallback onBlock,
    required VoidCallback onClearChat,
    required VoidCallback onDelete,
  }) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final selected = await showMenu<String>(
      context: context,
      color:isDark ? AppColors.darkBg : AppColors.lightBg,
      elevation: 0,
      constraints: const BoxConstraints(
        minWidth: 190,
        maxWidth: 210,
      ),
      position: RelativeRect.fromRect(
        Rect.fromLTWH(
          details.globalPosition.dx,
          details.globalPosition.dy,
          1,
          1,
        ),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: "archive",
          padding: EdgeInsets.zero,
          child: _ChatActionItem(
            icon: Icons.archive_outlined,
            title: "Archive",
          ),
        ),
        PopupMenuItem<String>(
          value: "mute",
          padding: EdgeInsets.zero,
          child: _ChatActionItem(
            icon: Icons.notifications_off_outlined,
            title: "Mute",
          ),
        ),
        PopupMenuItem<String>(
          value: "favourite",
          padding: EdgeInsets.zero,
          child: _ChatActionItem(
            icon: Icons.favorite_border_rounded,
            title: "Add to Favourites",
          ),
        ),
        PopupMenuItem<String>(
          value: "list",
          padding: EdgeInsets.zero,
          child: _ChatActionItem(
            icon: Icons.list_alt_rounded,
            title: "Add to list",
          ),
        ),
        PopupMenuItem<String>(
          value: "block",
          padding: EdgeInsets.zero,
          child: _ChatActionItem(
            icon: Icons.block_rounded,
            title: "Block",
          ),
        ),
        PopupMenuItem<String>(
          value: "clear",
          padding: EdgeInsets.zero,
          child: _ChatActionItem(
            icon: Icons.cancel_outlined,
            title: "Clear chat",
          ),
        ),
        PopupMenuItem<String>(
          value: "delete",
          padding: EdgeInsets.zero,
          child: _ChatActionItem(
            icon: Icons.delete_outline_rounded,
            title: "Delete chat",
            isDanger: true,
            isLast: true,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    );

    if (selected == null) return;

    switch (selected) {
      case "archive": onArchive(); break;
      case "mute": onMute(); break;
      case "favourite": onFavourite(); break;
      case "list": onAddToList(); break;
      case "block": onBlock(); break;
      case "clear": onClearChat(); break;
      case "delete": onDelete(); break;
    }
  }
}

class _ChatActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDanger;
  final bool isLast;
  final bool isDark;

  const _ChatActionItem({
    required this.icon,
    required this.title,
    this.isDanger = false,
    this.isLast = false,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        // color: const Color(0xFF3F3F3F),
        borderRadius: BorderRadius.vertical(
          top: title == "Archive" ? const Radius.circular(AppRadius.full) : Radius.zero,
          bottom: isLast ? const Radius.circular(14) : Radius.zero,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Icon(
                    icon,
                    size: 21,
                    color: isDanger ? Colors.redAccent :isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isDanger ? Colors.redAccent :isDark ? Colors.white : AppColors.lightTextPrimary,
                        fontSize: 15.5,height: 2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (!isLast)
            Divider(
              height: 1,
              thickness: 0.4,
              color: Colors.black.withOpacity(0.16),
              indent: 12,
              endIndent: 12,
            ),
        ],
      ),
    );
  }
}

class ActionConfirmSheet {
  static Future<void> show({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String message,
    required String confirmText,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.68),
      isScrollControlled: true,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 14),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.09)
                      : Colors.white.withOpacity(0.88),
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(
                    color: isDark
                        ? Colors.white.withOpacity(0.12)
                        : Colors.white.withOpacity(0.95),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(
                        color: confirmColor.withOpacity(0.16),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon,
                        color: confirmColor,
                        size: 28,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white
                            : AppColors.lightTextPrimary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isDark
                            ? Colors.white70
                            : AppColors.lightTextSecondary,
                        fontSize: 13,
                        height: 1.32,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 43,
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.16)
                                      : Colors.black.withOpacity(0.12),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Text(
                                "Cancel",
                                style: TextStyle(
                                  color: isDark
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: SizedBox(
                            height: 43,
                            child: ElevatedButton(
                              onPressed: onConfirm,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: confirmColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(999),
                                ),
                              ),
                              child: Text(
                                confirmText,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}





