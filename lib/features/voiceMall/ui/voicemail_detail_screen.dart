
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/app_assets.dart';
import '../controller/voicemail_controller.dart';
import '../model/voicemail_model.dart';
import 'widgets/voicemail_player_card.dart';

class VoicemailDetailScreen extends StatelessWidget {
  VoicemailDetailScreen({super.key});

  final VoicemailController controller = Get.find<VoicemailController>();

  @override
  Widget build(BuildContext context) {
    // final VoicemailModel voicemail = Get.arguments as VoicemailModel;
    final voicemail = ModalRoute.of(context)!.settings.arguments as VoicemailModel;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: Get.back,
                        child: Container(
                          height: 42,
                          width: 42,
                          decoration: BoxDecoration(
                            color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isDark ? Colors.white12 : Colors.black12,
                            ),
                          ),
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: theme.colorScheme.onSurface,
                            size: 18,
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      CircleAvatar( radius: 18, backgroundImage: NetworkImage(voicemail.image)),

                      const SizedBox(width: 8),

                      Expanded(
                        child: Text(
                          voicemail.name,
                          style: TextStyle(
                            color: theme.colorScheme.onSurface,
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      Container(
                        height: 42,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: isDark ? Colors.white12 : Colors.black12,
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(AppAssets.videoIcon, color: theme.colorScheme.onSurface),
                            const SizedBox(width: 16),
                            Image.asset(AppAssets.callIcon, color: theme.colorScheme.onSurface),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 26),

                Text(
                  "15 June 2026 at 12:15 PM",
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withOpacity(0.55),
                    fontSize: 11,
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: VoicemailPlayerCard(voicemail: voicemail),
                ),

                const Spacer(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

