import 'dart:ui';
import 'package:flutter/material.dart';

import '../../model/profile_option_model.dart';
import 'profile_option_tile.dart';

class ProfileOptionCard extends StatelessWidget {
  final List<ProfileOptionModel> options;
  final ValueChanged<ProfileOptionModel> onTap;
  final ValueChanged<ProfileOptionModel> onToggle;

  const ProfileOptionCard({
    super.key,
    required this.options,
    required this.onTap,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 22, sigmaY: 22),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.14)
                : Colors.white.withOpacity(0.78),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.14)
                  : Colors.white.withOpacity(0.95),
            ),
          ),
          child: Column(
            children: List.generate(options.length, (index) {
              final option = options[index];

              return ProfileOptionTile(
                option: option,
                showDivider: index != options.length - 1,
                onTap: () => onTap(option),
                onToggle: (_) => onToggle(option),
              );
            }),
          ),
        ),
      ),
    );
  }
}