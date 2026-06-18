import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/theme_route.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/widgets_route.dart';
import '../../model/call_item_model.dart';
import 'package:get/get.dart';
import '../call_info_screen.dart';

class CallListTile extends StatefulWidget {
  final CallItemModel call;

  const CallListTile({
    super.key,
    required this.call,
  });

  @override
  State<CallListTile> createState() => _CallListTileState();
}

class _CallListTileState extends State<CallListTile> {
  final GlobalKey _key = GlobalKey();

  void _showContextMenu() {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.sizeOf(context).height;

    // Estimate menu height
    const double menuHeight = 160;
    final bool showAbove = position.dy + size.height + menuHeight > screenHeight;

    showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.15),
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: Stack(
            children: [
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(color: Colors.transparent),
                ),
              ),
              // Original tile rendered on top of blur
              Positioned(
                top: position.dy,
                left: position.dx,
                width: size.width,
                height: size.height,
                child: Material(
                  color: Colors.transparent,
                  child: _buildTile(context, isDark),
                ),
              ),
              // Glassmorphism menu
              Positioned(
                top: showAbove ? position.dy - menuHeight - 8 : position.dy + size.height + 8,
                left: position.dx + 16,
                width: MediaQuery.sizeOf(context).width * 0.55,
                child: Material(
                  color: Colors.transparent,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isDark ? Colors.white.withOpacity(0.15) : Colors.black.withOpacity(0.08),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildMenuItem(AppAssets.videoIcon, "Video call", isDark),
                            Divider(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05), height: 1),
                            _buildMenuItem(AppAssets.callIcon, "Audio call", isDark),
                            Divider(color: isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05), height: 1),
                            _buildMenuItem(AppAssets.commentIcons, "Message", isDark),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMenuItem(String icon, String title, bool isDark) {
    return InkWell(
      onTap: () {
        Get.back(); // close menu
        // TODO: Action for menu
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 20,
              height: 20,
              color: isDark ? Colors.white : Colors.black87,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: isDark ? Colors.white : Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        Get.to(() => CallInfoScreen(call: widget.call));
      },
      onLongPress: _showContextMenu,
      child: Container(
        key: _key,
        color: Colors.transparent,
        child: _buildTile(context, isDark),
      ),
    );
  }

  Widget _buildTile(BuildContext context, bool isDark) {
    final nameColor = widget.call.isMissed
        ? AppColors.error
        : isDark ? Colors.white : AppColors.lightTextPrimary;

    final subColor = isDark ? Colors.white60 : AppColors.lightTextMuted;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          AvatarWidget(
            name: widget.call.name,
            imageUrl: widget.call.avatar,
            size: 48,
            showStatus: false,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.call.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: nameColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Image.asset(
                      AppAssets.missedCallIcon,
                      color: isDark ? Colors.white : AppColors.lightTextPrimary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.call.time,
                      style: TextStyle(
                        color: subColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.all(7),
              child: Image.asset(
                widget.call.type == CallType.video ? AppAssets.videoIcon : AppAssets.callIcon,
                width: 24, height: 24,
                color: isDark ? Colors.white : AppColors.lightTextPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}