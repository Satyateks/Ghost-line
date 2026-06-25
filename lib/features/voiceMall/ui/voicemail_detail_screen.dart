
import 'dart:ui';

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
                        child: SizedBox(
                          height: 42,
                          width: 42,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Soft outer glow
                              Positioned.fill(
                                child: CustomPaint(
                                  painter: _BackCircleOuterGlowPainter(
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
                                  painter: _BackCircleBorderPainter(
                                    isDark: isDark,
                                  ),
                                ),
                              ),

                              Icon(
                                Icons.arrow_back_ios_new,
                                color: theme.colorScheme.onSurface.withOpacity(0.92),
                                size: 18,
                              ),
                            ],
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

                      CustomPaint(
                        painter: _VideoCallPillOuterGlowPainter(isDark: isDark),
                        foregroundPainter: _VideoCallPillBorderPainter(isDark: isDark),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 16,
                              sigmaY: 16,
                            ),
                            child: Container(
                              height: 42,
                              padding: const EdgeInsets.symmetric(horizontal: 14),
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
                                    color: theme.colorScheme.onSurface.withOpacity(0.92),
                                  ),
                                  const SizedBox(width: 16),
                                  Image.asset(
                                    AppAssets.callIcon,
                                    height: 22,
                                    color: theme.colorScheme.onSurface.withOpacity(0.92),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
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
class _BackCircleOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _BackCircleOuterGlowPainter({
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
  bool shouldRepaint(covariant _BackCircleOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _BackCircleBorderPainter extends CustomPainter {
  final bool isDark;

  const _BackCircleBorderPainter({
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

    // Main thin border
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

    // Top soft shine
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
  bool shouldRepaint(covariant _BackCircleBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
class _VideoCallPillOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _VideoCallPillOuterGlowPainter({
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
  bool shouldRepaint(covariant _VideoCallPillOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _VideoCallPillBorderPainter extends CustomPainter {
  final bool isDark;

  const _VideoCallPillBorderPainter({
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

    // Bottom soft edge
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
  bool shouldRepaint(covariant _VideoCallPillBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}