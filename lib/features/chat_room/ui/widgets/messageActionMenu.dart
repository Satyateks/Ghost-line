
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../core/theme/theme_route.dart';

class MessageActionMenu {
  static Future<void> show({
    required BuildContext context,
    required LongPressStartDetails details,
    required dynamic message,
    required VoidCallback onCopy,
    required VoidCallback onForward,
    required VoidCallback onDelete,
    required VoidCallback onPin,
    required VoidCallback onStar,
  }) async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
   final isDark = Theme.of(context).brightness == Brightness.dark;
    final selected = await showMenu<String>(
      context: context,
      color: isDark ? Color(0xFF3D3D3D) : AppColors.lightBg,
      elevation: 0,
      constraints: const BoxConstraints( minWidth: 190, maxWidth: 220),
      position: RelativeRect.fromRect(
        Rect.fromLTWH( details.globalPosition.dx, details.globalPosition.dy, 1, 1),
        Offset.zero & overlay.size,
      ),
      items: [
        PopupMenuItem<String>(
          value: "copy",
          padding: EdgeInsets.zero,
          child: _MessageActionItem(
            icon: Icons.copy_rounded,
            title: "Copy",isDark: isDark,
          ),
        ),
        PopupMenuItem<String>(
          value: "forward",
          padding: EdgeInsets.zero,
          child: _MessageActionItem(
            icon: Icons.forward_rounded,
            title: "Forward",isDark: isDark,
          ),
        ),
        PopupMenuItem<String>(
          value: "pin",
          padding: EdgeInsets.zero,
          child: _MessageActionItem(
            icon: Icons.push_pin_outlined,
            title: "Pin message",isDark: isDark,
          ),
        ),
        PopupMenuItem<String>(
          value: "star",
          padding: EdgeInsets.zero,
          child: _MessageActionItem(
            icon: Icons.star_border_rounded,
            title: "Star message",isDark: isDark,
          ),
        ),
        PopupMenuItem<String>(
          value: "delete",
          padding: EdgeInsets.zero,
          child: _MessageActionItem(
            icon: Icons.delete_outline_rounded,
            title: "Delete message",
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
      case "copy": onCopy(); break;
      case "forward": onForward(); break;
      case "pin": onPin(); break;
      case "star": onStar(); break;
      case "delete": onDelete(); break;
    }
  }
}




class _MessageActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDanger;
  final bool isLast;
  final bool isDark;

  const _MessageActionItem({
    required this.icon,
    required this.title,
    this.isDanger = false,
    this.isLast = false,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        // color:isDark ? Colors.white70 : AppColors.lightTextPrimary,
        borderRadius: BorderRadius.vertical(
          top: title == "Copy" ? const Radius.circular(14) : Radius.zero,
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
                    size: 19,
                    color: isDanger ? Colors.redAccent :isDark ? Colors.white : AppColors.lightTextPrimary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: isDanger ? Colors.redAccent :isDark?Colors.white : AppColors.lightTextPrimary,
                        fontSize: 13.5,
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
              color: Colors.black.withOpacity(0.4),
              indent: 12,
              endIndent: 12,
            ),
        ],
      ),
    );
  }
}


class MessageActionSheet {
  static Future<void> show({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String messageText,
    required String confirmText,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final titleColor=isDark ? Colors.white : AppColors.lightTextPrimary;
    final messageTextClr=isDark ? Colors.white : AppColors.lightTextSecondary;

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
                    // Container(
                    //   height: 54,
                    //   width: 54,
                    //   decoration: BoxDecoration(color: confirmColor.withOpacity(0.16),shape: BoxShape.circle),
                    //   child: Icon(icon, color: confirmColor, size: 28),
                    // ),

                    const SizedBox(height: 14),
                    Text(title,textAlign: TextAlign.center,style: AppTextStyles.h3(titleColor)),
                    const SizedBox(height: 8),
                    Text(messageText,textAlign: TextAlign.center,style: AppTextStyles.bodyLarge(messageTextClr)),

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
                              child:Text('Cancel',style: AppTextStyles.bodyLarge(messageTextClr))
  
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.authButton)),
                              ),
                              child:Text(confirmText,style: AppTextStyles.bodyLarge(Colors.white))
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




