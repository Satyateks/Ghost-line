import 'dart:ui';
import 'package:flutter/material.dart';


import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/app_assets.dart';
import '../../model/profile_models.dart';

class ProfileMenuCard extends StatelessWidget {
  final List<ProfileMenuModel> menus;
  final ValueChanged<ProfileMenuModel> onTap;
  final VoidCallback onLogout;

  const ProfileMenuCard({
    super.key,
    required this.menus,
    required this.onTap,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomPaint(
      painter: _ProfileHeaderOuterGlowPainter(
        isDark: isDark,
      ),
      foregroundPainter: _ProfileHeaderBorderPainter(
        isDark: isDark,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 21, sigmaY: 21),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.82),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? Colors.white.withOpacity(0.12) : Colors.white.withOpacity(0.95),
              ),
            ),
            child: Column(
              children: [
                ...List.generate(menus.length, (index) {
                  final menu = menus[index];
                  return _ProfileMenuTile(menu: menu, showDivider: true, onTap: () => onTap(menu));
                }),

                InkWell(
                  onTap: onLogout,
                  child: SizedBox(
                    height: 60,
                    child: Row(
                      children: [
                        Image.asset(AppAssets.logout,height: 27),
                        SizedBox(width: 7),
                        Expanded(
                          child: Text(
                            'Log out of this account',
                            style: TextStyle(
                              color: AppColors.error,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProfileMenuTile extends StatelessWidget {
  final ProfileMenuModel menu;
  final bool showDivider;
  final VoidCallback onTap;

  const _ProfileMenuTile({ required this.menu, required this.showDivider, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;

    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              children: [
                Icon(menu.icon, color: textColor, size: 27),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    menu.title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios_rounded, color: textColor, size: 21),
              ],
            ),
          ),
          Divider(height: 1, color: isDark ? Colors.white.withOpacity(0.10) : Colors.black.withOpacity(0.08)),
        ],
      ),
    );
  }
}

class _ProfileHeaderOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _ProfileHeaderOuterGlowPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 24.0;

    final rect = Rect.fromLTWH(
      1.5,
      1.5,
      size.width - 3,
      size.height - 3,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(radius),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3.6,
      )
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.13),
          Colors.white.withOpacity(0.035),
          Colors.black.withOpacity(0.32),
        ]
            : [
          Colors.white.withOpacity(0.84),
          Colors.white.withOpacity(0.30),
          Colors.black.withOpacity(0.07),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _ProfileHeaderOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _ProfileHeaderBorderPainter extends CustomPainter {
  final bool isDark;

  const _ProfileHeaderBorderPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 24.0;

    final rect = Rect.fromLTWH(
      1,
      1,
      size.width - 2,
      size.height - 2,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      const Radius.circular(radius),
    );

    // Main thin glass border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.22),
          Colors.white.withOpacity(0.075),
          Colors.black.withOpacity(0.34),
        ]
            : [
          Colors.white.withOpacity(0.92),
          Colors.white.withOpacity(0.45),
          Colors.black.withOpacity(0.075),
        ],
        stops: const [0.0, 0.48, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, borderPaint);

    // Top soft shine
    final topShinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.05
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.85,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(isDark ? 0.10 : 0.34),
          Colors.white.withOpacity(isDark ? 0.20 : 0.68),
          Colors.white.withOpacity(isDark ? 0.08 : 0.28),
          Colors.white.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      const Offset(30, 2.0),
      Offset(size.width - 30, 2.0),
      topShinePaint,
    );

    // Bottom soft glass edge
    final bottomEdgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.95
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.85,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(0.030),
          Colors.white.withOpacity(0.065),
          Colors.white.withOpacity(0.030),
          Colors.white.withOpacity(0.00),
        ]
            : [
          Colors.black.withOpacity(0.00),
          Colors.black.withOpacity(0.025),
          Colors.black.withOpacity(0.050),
          Colors.black.withOpacity(0.025),
          Colors.black.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      Offset(30, size.height - 2.0),
      Offset(size.width - 30, size.height - 2.0),
      bottomEdgePaint,
    );

    // Inner soft depth
    final innerRect = Rect.fromLTWH(
      4,
      4,
      size.width - 8,
      size.height - 8,
    );

    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      const Radius.circular(radius - 2),
    );

    final innerShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        1.1,
      )
      ..color = isDark
          ? Colors.black.withOpacity(0.20)
          : Colors.white.withOpacity(0.24);

    canvas.drawRRect(innerRRect, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant _ProfileHeaderBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}



