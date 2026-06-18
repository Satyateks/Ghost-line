
import 'package:flutter/material.dart';

class VoicemailWaveform extends StatelessWidget {
  final bool isPlaying;
  final double height;

  const VoicemailWaveform({
    super.key,
    required this.isPlaying,
    this.height = 52,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primary;
    final inactiveColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white30
        : Colors.black26;

    final values = [
      18.0, 34.0, 22.0, 42.0, 26.0, 48.0, 20.0, 38.0, 28.0, 44.0,
      24.0, 36.0, 20.0, 45.0, 30.0, 50.0, 24.0, 40.0, 26.0, 34.0,
      18.0, 22.0, 30.0, 40.0, 26.0, 20.0, 18.0, 16.0, 24.0, 18.0,
      20.0, 16.0, 14.0, 18.0, 16.0, 20.0,
    ];

    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(values.length, (index) {
          final isActive = index < 23;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1.3),
              child: Container(
                height: values[index],
                decoration: BoxDecoration(
                  color: isActive ? activeColor : inactiveColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

