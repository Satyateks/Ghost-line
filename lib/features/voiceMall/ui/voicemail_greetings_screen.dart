
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/voicemail_controller.dart';
import 'widgets/greeting_tile.dart';
import 'widgets/voicemail_waveform.dart';

class VoicemailGreetingsScreen extends StatelessWidget {
  VoicemailGreetingsScreen({super.key});

  final VoicemailController controller = Get.find<VoicemailController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 96),
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          border: Border.all(
                            color: isDark ? Colors.white12 : Colors.black12,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.arrow_back_ios_new_rounded,
                              size: 16,
                              color: theme.colorScheme.onSurface,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Greetings",
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                Container(
                  padding: const EdgeInsets.fromLTRB(12, 10, 8, 12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF202020) : Colors.white,
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
                  child: Obx(
                    () => Column(
                      children: [
                        _GreetingRadioRow(
                          title: "Default",
                          value: GreetingType.defaultGreeting,
                          groupValue: controller.selectedGreeting.value,
                          onChanged: controller.selectGreeting,
                        ),

                        Divider(
                          height: 16,
                          color: theme.dividerColor.withOpacity(0.6),
                        ),

                        _GreetingRadioRow(
                          title: "Custom",
                          value: GreetingType.customGreeting,
                          groupValue: controller.selectedGreeting.value,
                          onChanged: controller.selectGreeting,
                        ),

                        Divider(
                          height: 20,
                          color: theme.dividerColor.withOpacity(0.6),
                        ),

                        const VoicemailWaveform(
                          isPlaying: false,
                          height: 56,
                        ),

                        const SizedBox(height: 10),

                        Center(
                          child: SizedBox(
                            height: 42,
                            width: 112,
                            child: ElevatedButton(
                              onPressed: controller.recordGreeting,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colorScheme.primary,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                              child: const Text(
                                "Record",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _GreetingActionIcon(icon: Icons.replay_rounded, onTap: () {}),
                            _GreetingActionIcon(icon: Icons.play_arrow_rounded, size: 32, onTap: () {}, ),
                            _GreetingActionIcon(
                              icon: Icons.volume_up_outlined,
                              onTap: () {},
                            ),
                            _GreetingActionIcon(
                              icon: Icons.delete_outline_rounded,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Text(
                  "Previously used",
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF202020) : Colors.white,
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
                  child: Obx(
                    () => Column(
                      children: [
                        ...controller.greetings.map(
                          (item) => Column(
                            children: [
                              GreetingTile(greeting: item),
                              if (controller.greetings.last.id != item.id)
                                Divider(
                                  height: 1,
                                  color: theme.dividerColor.withOpacity(0.5),
                                ),
                            ],
                          ),
                        ),

                        if (controller.greetings.isEmpty)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "No previous greeting found",
                              style: TextStyle(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GreetingRadioRow extends StatelessWidget {
  final String title;
  final GreetingType value;
  final GreetingType groupValue;
  final Function(GreetingType) onChanged;

  const _GreetingRadioRow({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;

    return GestureDetector(
      onTap: () => onChanged(value),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 36,
        child: Row(
          children: [
            Icon(
              selected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_off_rounded,
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GreetingActionIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;

  const _GreetingActionIcon({
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

