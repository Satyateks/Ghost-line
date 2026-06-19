import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/glass_scaffold.dart';
import '../controller/chat_room_controller.dart';
import '../model/message_model.dart';
import 'widgets/audio_message_bubble.dart';
import 'widgets/chat_room_app_bar.dart';
import 'widgets/message_bubble.dart';
import 'widgets/message_input_bar.dart';

class ChatRoomScreen extends StatelessWidget {
  ChatRoomScreen({
    super.key,
    this.name = 'Satyam Mishra',
    this.avatar = 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
  });

  final String name;
  final String avatar;

  final ChatRoomController controller = Get.put(ChatRoomController());

  @override
  Widget build(BuildContext context) {
    return GlassScaffold(
      safeArea: true,
      resizeToAvoidBottomInset: true,
      appBar: ChatRoomAppBar( name: name, avatar: avatar),
      body: Column(
        children: [
          const SizedBox(height: 6),

          _DisappearInfo(),

          const SizedBox(height: 28),

          _DateSeparator(),

          const SizedBox(height: 10),

          Expanded( child: Obx( () => ListView.builder(
                reverse: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 12),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final message = controller.messages[index];

                  if (message.type == MessageType.audio) return AudioMessageBubble(message: message);
                  return MessageBubble(message: message);
                },
              ),
            ),
          ),

          MessageInputBar(controller: controller),
        ],
      ),
    );
  }
}

class _DisappearInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.access_time_rounded,
          size: 12,
          color: isDark ? Colors.white38 : Colors.black38,
        ),
        const SizedBox(width: 4),
        Text(
          'Messages will disappear after 24 hours',
          style: TextStyle(
            color: isDark ? Colors.white38 : Colors.black45,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DateSeparator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      'Today 02:11 PM',
      style: TextStyle(
        color: isDark ? Colors.white38 : Colors.black38,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}



