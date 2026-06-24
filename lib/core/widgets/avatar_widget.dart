// ignore_for_file: deprecated_member_use, unnecessary_underscores

import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_text_styles.dart';

class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? asset;
  final String name;
  final double size;
  final bool isOnline;
  final bool showStatus;
  final VoidCallback? onTap;

  const AvatarWidget({
    super.key,
    this.imageUrl,
    this.asset,
    required this.name,
    this.size = 48,
    this.isOnline = false,
    this.showStatus = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(name);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryBlueLight, AppColors.primaryPurple],
              ),
              border: Border.all(
                color: isDark ? Colors.white.withOpacity(0.28) : AppColors.lightBorder, 
                width: 1,
              ),
            ),
            child: ClipOval(child: _avatarChild(initials)),
          ),
          if (showStatus)
            Positioned(
              right: 1,
              bottom: 1,
              child: Container(
                height: size * 0.24,
                width: size * 0.24,
                decoration: BoxDecoration(
                  color: isOnline 
                      ? AppColors.online 
                      : (isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _avatarChild(String initials) {
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      return Image.network(
        imageUrl!,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _initials(initials),
      );
    }

    if (asset != null && asset!.isNotEmpty) {return Image.asset(asset!, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _initials(initials));}

    return _initials(initials);
  }

  Widget _initials(String initials) {return Center(child: Text(initials, style: AppTextStyles.buttonLarge(Colors.white)));}

  String _getInitials(String value) {
    final words = value.trim().split(RegExp(r'\s+'));
    if (words.isEmpty || value.trim().isEmpty) return "?";
    if (words.length == 1) return words.first.characters.first.toUpperCase();
    return "${words[0].characters.first}${words[1].characters.first}".toUpperCase();
  }
}
