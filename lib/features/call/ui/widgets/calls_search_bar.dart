import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/theme/theme_route.dart';

class CallsSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const CallsSearchBar({
    super.key,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        height: 42,
        child: Stack(
          children: [
            // Soft outer glass glow
            Positioned.fill(
              child: CustomPaint(
                painter: _CallsSearchOuterGlowPainter(
                  isDark: isDark,
                ),
              ),
            ),

            // Main glass body
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 16,
                    sigmaY: 16,
                  ),
                  child: Container(
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
                  ),
                ),
              ),
            ),

            // Thin border + shine
            Positioned.fill(
              child: CustomPaint(
                painter: _CallsSearchGlassBorderPainter(
                  isDark: isDark,
                ),
              ),
            ),

            // TextField
            Positioned.fill(
              child: TextField(
                onChanged: onChanged,
                cursorColor: AppColors.buttonBlue,
                style: TextStyle(
                  color: isDark ? Colors.white : AppColors.lightTextPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  filled: false,
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    size: 21,
                    color: isDark
                        ? Colors.white.withOpacity(0.56)
                        : Colors.black.withOpacity(0.42),
                  ),
                  hintText: 'Search name, numbers',
                  hintStyle: TextStyle(
                    color: isDark
                        ? Colors.white.withOpacity(0.52)
                        : Colors.black.withOpacity(0.42),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  contentPadding: const EdgeInsets.only(
                    top: 11,
                    bottom: 11,
                    right: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(999),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallsSearchOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _CallsSearchOuterGlowPainter({
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
      ..strokeWidth = 2.4
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3.2,
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
  bool shouldRepaint(covariant _CallsSearchOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _CallsSearchGlassBorderPainter extends CustomPainter {
  final bool isDark;

  const _CallsSearchGlassBorderPainter({
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
      ..strokeWidth = 1.05
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.8,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(isDark ? 0.11 : 0.38),
          Colors.white.withOpacity(isDark ? 0.20 : 0.70),
          Colors.white.withOpacity(isDark ? 0.09 : 0.32),
          Colors.white.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      Offset(radius + 18, 2.0),
      Offset(size.width - radius - 18, 2.0),
      topShinePaint,
    );

    // Bottom subtle edge
    final bottomEdgePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.9
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.8,
      )
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: isDark
            ? [
          Colors.white.withOpacity(0.00),
          Colors.white.withOpacity(0.035),
          Colors.white.withOpacity(0.070),
          Colors.white.withOpacity(0.035),
          Colors.white.withOpacity(0.00),
        ]
            : [
          Colors.black.withOpacity(0.00),
          Colors.black.withOpacity(0.030),
          Colors.black.withOpacity(0.055),
          Colors.black.withOpacity(0.030),
          Colors.black.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      Offset(radius + 18, size.height - 2.0),
      Offset(size.width - radius - 18, size.height - 2.0),
      bottomEdgePaint,
    );

    // Inner soft depth
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
      ..strokeWidth = 1.0
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        1.0,
      )
      ..color = isDark
          ? Colors.black.withOpacity(0.22)
          : Colors.white.withOpacity(0.26);

    canvas.drawRRect(innerRRect, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant _CallsSearchGlassBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}