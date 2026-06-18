import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/voicemail_controller.dart';
import '../../model/voicemail_model.dart';
import 'voicemail_waveform.dart';

class VoicemailPlayerCard extends StatelessWidget {
  final VoicemailModel voicemail;

  const VoicemailPlayerCard({
    super.key,
    required this.voicemail,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VoicemailController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Obx(() {
      final latest = controller.voicemails.firstWhereOrNull(
        (item) => item.id == voicemail.id,
      );

      final isPlaying = latest?.isPlaying ?? voicemail.isPlaying;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF242424) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isDark ? Colors.white12 : Colors.black12,
          ),
          boxShadow: isDark
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.07),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VoicemailWaveform(isPlaying: isPlaying),

            Row(
              children: [
                _PlayerIcon(
                  icon: Icons.ios_share_rounded,
                  onTap: () {},
                ),
                const Spacer(),
                _PlayerIcon(
                  icon: Icons.replay_rounded,
                  onTap: () {},
                ),
                _PlayerIcon(
                  icon: isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  size: 32,
                  onTap: () => controller.toggleVoicemailPlay(voicemail.id),
                ),
                _PlayerIcon(
                  icon: Icons.volume_up_outlined,
                  onTap: () {},
                ),
                const Spacer(),
                _PlayerIcon(
                  icon: Icons.delete_outline_rounded,
                  onTap: () => controller.deleteVoicemail(voicemail.id),
                ),
              ],
            ),

            Divider(
              height: 22,
              color: theme.dividerColor.withOpacity(0.5),
            ),

            Text(
              "Lorem ipsum dolor sit amet consectetur. Ultrices sed leo donec eu. Mauris libero rhoncus eu velit vitae. Nisl nulla felis in proin vel non commodo tortor.",
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.8),
                fontSize: 13,
                height: 1.25,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _PlayerIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const _PlayerIcon({
    required this.icon,
    required this.onTap,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      visualDensity: VisualDensity.compact,
      onPressed: onTap,
      icon: Icon(
        icon,
        size: size,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}

