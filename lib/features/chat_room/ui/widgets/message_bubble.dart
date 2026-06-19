import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../core/theme/theme_route.dart';
import '../../../home/controller/home_controller.dart';
import '../../model/message_model.dart';
import '../forward_message_screen.dart';
import 'messageActionMenu.dart';

class MessageBubble extends StatelessWidget {
  final MessageModel message;
  MessageBubble({super.key, required this.message});

  final HomeController homeController = Get.find<HomeController>();
  void _showFullScreenImage(BuildContext context, String path) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Center(child: InteractiveViewer(child: Image.file(File(path)))),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bubbleColor = isMe ? AppColors.buttonBlue : isDark ? const Color(0xFF26262B) : Colors.white;
    final textColor = isMe ? Colors.white : isDark ? Colors.white : AppColors.lightTextPrimary;

    Widget content;
    if (message.type == MessageType.image && message.filePath != null) {
      content = GestureDetector(
        onTap: () => _showFullScreenImage(context, message.filePath!),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(File(message.filePath!), width: 200, height: 200, fit: BoxFit.cover),
        ),
      );
    } else if (message.type == MessageType.document && message.filePath != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.insert_drive_file_rounded, color: textColor, size: 28),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message.message.isNotEmpty ? message.message : 'Document',
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    } else {
      content = GestureDetector(
        onLongPressStart: (details) {
          MessageActionMenu.show(
            context: context,
            details: details,
            message: message,
            onCopy: () {
              Clipboard.setData(
                ClipboardData(text: message.message),
              );
            },
            onForward: () {
              Get.to( () => ForwardMessageScreen(message: message));
            },
            onDelete: () {
              MessageActionSheet.show(
                context: context,
                icon: Icons.delete_outline_rounded,
                title: "Delete Message?",
                messageText: "Are you sure you want to delete this message?",
                confirmText: "Delete",
                confirmColor: Colors.redAccent,
                onConfirm: () {
                  homeController.deleteMessage(message.id);
                  Get.back();
                },
              );
            },
            onPin: () {
              MessageActionSheet.show(
                context: context,
                icon: Icons.push_pin_outlined,
                title: "Pin Message?",
                messageText: "This message will be pinned in this chat.",
                confirmText: "Pin",
                confirmColor: AppColors.buttonBlue,
                onConfirm: () {
                  homeController.pinMessage(message.id);
                  Get.back();
                },
              );
            },
            onStar: () {
              MessageActionSheet.show(
                context: context,
                icon: Icons.star_border_rounded,
                title: "Star Message?",
                messageText: "This message will be saved in your starred messages.",
                confirmText: "Star",
                confirmColor: AppColors.buttonBlue,
                onConfirm: () {
                  homeController.starMessage(message.id);
                  Get.back();
                },
              );
            },
          );
        },
        child: Text(
          message.message,
          style: AppTextStyles.bodyLarge(textColor),
        ),
      );

     /* content = Text(
        message.message,
        style: AppTextStyles.bodyLarge(textColor),
        // style: TextStyle(
        //   color: textColor,fontSize: 15,height: 1.35,
        //   fontWeight: FontWeight.w500),
      );*/
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 10,
          left: isMe ? 70 : 0,
          right: isMe ? 0 : 70,
        ),
        padding: message.type == MessageType.image
            ? const EdgeInsets.all(4)
            : const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
        decoration: BoxDecoration(
          color: message.type == MessageType.image ? Colors.transparent : bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8),
            bottomLeft: Radius.circular(isMe ? 8 : 2),
            bottomRight: Radius.circular(isMe ? 2 : 8),
          ),
          boxShadow: message.type == MessageType.image ? [] : [
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.10 : 0.06),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: content,
      ),
    );
  }
}


