import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../core/theme/theme_route.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/widgets/widgets_route.dart';
import '../../../user_profile/ui/user_profile_screen.dart';

class ChatRoomAppBar extends StatelessWidget {
  final String name;
  final String avatar;

  const ChatRoomAppBar({
    super.key,
    required this.name,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
      child: Row(
        children: [
          _CircleGlassButton(icon: Icons.arrow_back_ios_new_rounded, onTap: Get.back),

          const SizedBox(width: 12),

        /*  AvatarWidget(name: name, imageUrl: avatar, size: 34, showStatus: false),
          const SizedBox(width: 8),
          Expanded(
            child: Text( name, maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle( color: textColor, fontSize: 16, fontWeight: FontWeight.w700)),
          ),*/
          Expanded(
            child: InkWell(
              onTap: ()=> Get.to(UserProfileScreen(name: name, avatar: avatar)),
              borderRadius: BorderRadius.circular(999),
              child: Row(
                children: [
                  AvatarWidget(
                    name: name,
                    imageUrl: avatar,
                    size: 40,
                    showStatus: true,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          CustomPaint(
            painter: _CallActionPillOuterGlowPainter(
              isDark: isDark,
            ),
            foregroundPainter: _CallActionPillBorderPainter(
              isDark: isDark,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 16,
                  sigmaY: 16,
                ),
                child: Container(
                  height: 42,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: isDark
                          ? [
                        Colors.white.withOpacity(0.120),
                        Colors.white.withOpacity(0.075),
                        Colors.white.withOpacity(0.050),
                      ]
                          : [
                        Colors.white.withOpacity(0.92),
                        Colors.white.withOpacity(0.78),
                        Colors.white.withOpacity(0.66),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        AppAssets.videoIcon,
                        height: 22,
                        color: textColor,
                      ),
                      const SizedBox(width: 14),
                      Image.asset(
                        AppAssets.callIcon,
                        height: 22,
                        color: textColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _CircleGlassButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleGlassButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      splashColor: Colors.white.withOpacity(0.06),
      highlightColor: Colors.white.withOpacity(0.03),
      child: SizedBox(
        height: 42,
        width: 42,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Soft outer glow
            Positioned.fill(
              child: CustomPaint(
                painter: _CircleGlassOuterGlowPainter(
                  isDark: isDark,
                ),
              ),
            ),

            // Main glass body
            Positioned.fill(
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 14,
                    sigmaY: 14,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: isDark
                            ? [
                          Colors.white.withOpacity(0.120),
                          Colors.white.withOpacity(0.075),
                          Colors.white.withOpacity(0.050),
                        ]
                            : [
                          Colors.white.withOpacity(0.92),
                          Colors.white.withOpacity(0.78),
                          Colors.white.withOpacity(0.66),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Thin border + shine
            Positioned.fill(
              child: CustomPaint(
                painter: _CircleGlassBorderPainter(
                  isDark: isDark,
                ),
              ),
            ),

            Icon(
              icon,
              size: 24,
              color: isDark
                  ? Colors.white.withOpacity(0.92)
                  : AppColors.lightTextPrimary.withOpacity(0.90),
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleGlassOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _CircleGlassOuterGlowPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      1.5,
      1.5,
      size.width - 3,
      size.height - 3,
    );

    final circleRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: (size.width / 2) - 2,
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.3
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3.0,
      )
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.13),
          Colors.white.withOpacity(0.035),
          Colors.black.withOpacity(0.30),
        ]
            : [
          Colors.white.withOpacity(0.82),
          Colors.white.withOpacity(0.32),
          Colors.black.withOpacity(0.07),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);

    canvas.drawOval(circleRect, paint);
  }

  @override
  bool shouldRepaint(covariant _CircleGlassOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _CircleGlassBorderPainter extends CustomPainter {
  final bool isDark;

  const _CircleGlassBorderPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      1,
      1,
      size.width - 2,
      size.height - 2,
    );

    final circleRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: (size.width / 2) - 1.2,
    );

    // Main thin circular border
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.24),
          Colors.white.withOpacity(0.075),
          Colors.black.withOpacity(0.34),
        ]
            : [
          Colors.white.withOpacity(0.92),
          Colors.white.withOpacity(0.48),
          Colors.black.withOpacity(0.08),
        ],
        stops: const [0.0, 0.48, 1.0],
      ).createShader(rect);

    canvas.drawOval(circleRect, borderPaint);

    // Top curved shine
    final topShinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.15
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.75,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(isDark ? 0.13 : 0.40),
          Colors.white.withOpacity(isDark ? 0.25 : 0.72),
          Colors.white.withOpacity(isDark ? 0.10 : 0.34),
          Colors.white.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    final topArcRect = Rect.fromLTWH(
      8,
      3.5,
      size.width - 16,
      size.height - 16,
    );

    canvas.drawArc(
      topArcRect,
      3.55,
      2.30,
      false,
      topShinePaint,
    );

    // Bottom soft depth
    final bottomDepthPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.9,
      )
      ..color = isDark
          ? Colors.black.withOpacity(0.24)
          : Colors.black.withOpacity(0.055);

    final bottomArcRect = Rect.fromLTWH(
      8,
      8,
      size.width - 16,
      size.height - 10,
    );

    canvas.drawArc(
      bottomArcRect,
      0.65,
      1.85,
      false,
      bottomDepthPaint,
    );

    // Inner soft shadow
    final innerCircleRect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: (size.width / 2) - 4.2,
    );

    final innerShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        1.0,
      )
      ..color = isDark
          ? Colors.black.withOpacity(0.20)
          : Colors.white.withOpacity(0.26);

    canvas.drawOval(innerCircleRect, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant _CircleGlassBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
class _CallActionPillOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _CallActionPillOuterGlowPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      1.5,
      1.5,
      size.width - 3,
      size.height - 3,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(size.height / 2),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.3
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3.0,
      )
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.13),
          Colors.white.withOpacity(0.035),
          Colors.black.withOpacity(0.30),
        ]
            : [
          Colors.white.withOpacity(0.82),
          Colors.white.withOpacity(0.32),
          Colors.black.withOpacity(0.07),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _CallActionPillOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _CallActionPillBorderPainter extends CustomPainter {
  final bool isDark;

  const _CallActionPillBorderPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.height / 2;

    final rect = Rect.fromLTWH(
      1,
      1,
      size.width - 2,
      size.height - 2,
    );

    final rrect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(radius),
    );

    // Main thin border
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
          Colors.black.withOpacity(0.32),
        ]
            : [
          Colors.white.withOpacity(0.90),
          Colors.white.withOpacity(0.46),
          Colors.black.withOpacity(0.08),
        ],
        stops: const [0.0, 0.48, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, borderPaint);

    // Top soft shine
    final topShinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.75,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(isDark ? 0.10 : 0.36),
          Colors.white.withOpacity(isDark ? 0.19 : 0.68),
          Colors.white.withOpacity(isDark ? 0.08 : 0.30),
          Colors.white.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      Offset(radius + 8, 1.9),
      Offset(size.width - radius - 8, 1.9),
      topShinePaint,
    );

    // Bottom soft depth
    final bottomEdgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.75,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(0.030),
          Colors.white.withOpacity(0.060),
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
      Offset(radius + 8, size.height - 1.9),
      Offset(size.width - radius - 8, size.height - 1.9),
      bottomEdgePaint,
    );

    // Inner soft shadow
    final innerRect = Rect.fromLTWH(
      3.5,
      3.5,
      size.width - 7,
      size.height - 7,
    );

    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      Radius.circular(radius),
    );

    final innerShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        1.0,
      )
      ..color = isDark
          ? Colors.black.withOpacity(0.20)
          : Colors.white.withOpacity(0.24);

    canvas.drawRRect(innerRRect, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant _CallActionPillBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

