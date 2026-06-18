
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/voicemail_controller.dart';
import '../../model/greeting_model.dart';
 

class GreetingTile extends StatelessWidget {
  final GreetingModel greeting;

  const GreetingTile({
    super.key,
    required this.greeting,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VoicemailController>();
    final theme = Theme.of(context);

    return Obx(() {
      final latest = controller.greetings.firstWhereOrNull(
        (item) => item.id == greeting.id,
      );

      final isPlaying = latest?.isPlaying ?? false;

      return SizedBox(
        height: 58,
        child: Row(
          children: [
            GestureDetector(
              onTap: () => controller.toggleGreetingPlay(greeting.id),
              child: Icon(
                isPlaying
                    ? Icons.pause_circle_outline_rounded
                    : Icons.play_circle_outline_rounded,
                color: theme.colorScheme.onSurface,
                size: 25,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    greeting.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "${greeting.date} • ",
                    // "${greeting.date} • ${controller.formatDuration(greeting.duration)}",
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withOpacity(0.55),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),

            TextButton(
              onPressed: () => controller.useGreeting(greeting.id),
              child: Text(
                "Use",
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: () => controller.deleteGreeting(greeting.id),
              icon: Icon(
                Icons.delete_outline_rounded,
                color: theme.colorScheme.onSurface,
                size: 22,
              ),
            ),
          ],
        ),
      );
    });
  }
}



