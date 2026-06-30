import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/voicemail_controller.dart';
import '../../model/voicemail_model.dart';
import 'voicemail_waveform.dart';

class VoicemailPlayerCard extends StatelessWidget {
  final VoicemailModel voicemail;

  const VoicemailPlayerCard({
    super.key,
    required this.voicemail,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VoicemailController>();
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Obx(() {
      final latest = controller.voicemails.firstWhereOrNull(
            (item) => item.id == voicemail.id,
      );

      final isPlaying = latest?.isPlaying ?? voicemail.isPlaying;

      return _VoicemailGlassCard(
        isDark: isDark,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VoicemailWaveform(isPlaying: isPlaying),

            const SizedBox(height: 4),

            Row(
              children: [
                _PlayerIcon(
                  icon: Icons.ios_share_rounded,
                  onTap: () {},
                ),
                const Spacer(),
                _PlayerIcon(
                  icon: Icons.replay_rounded,
                  onTap: () {},
                ),
                _PlayerIcon(
                  icon: isPlaying
                      ? Icons.pause_rounded
                      : Icons.play_arrow_rounded,
                  size: 32,
                  isPrimary: true,
                  onTap: () => controller.toggleVoicemailPlay(voicemail.id),
                ),
                _PlayerIcon(
                  icon: Icons.volume_up_outlined,
                  onTap: () {},
                ),
                const Spacer(),
                _PlayerIcon(
                  icon: Icons.delete_outline_rounded,
                  onTap: () => controller.deleteVoicemail(voicemail.id),
                ),
              ],
            ),

            Divider(
              height: 22,
              color: theme.dividerColor.withOpacity(isDark ? 0.36 : 0.45),
            ),

            Text(
              "Lorem ipsum dolor sit amet consectetur. Ultrices sed leo donec eu. Mauris libero rhoncus eu velit vitae. Nisl nulla felis in proin vel non commodo tortor.",
              style: TextStyle(
                color: theme.colorScheme.onSurface.withOpacity(0.78),
                fontSize: 13,
                height: 1.25,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _VoicemailGlassCard extends StatelessWidget {
  final bool isDark;
  final Widget child;

  const _VoicemailGlassCard({
    required this.isDark,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 18.0;

    return CustomPaint(
      painter: _VoicemailCardOuterGlowPainter(
        isDark: isDark,
        radius: radius,
      ),
      foregroundPainter: _VoicemailCardBorderPainter(
        isDark: isDark,
        radius: radius,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 18,
            sigmaY: 18,
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(12, 14, 12, 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                  Colors.white.withOpacity(0.115),
                  Colors.white.withOpacity(0.070),
                  Colors.white.withOpacity(0.045),
                ]
                    : [
                  Colors.white.withOpacity(0.94),
                  Colors.white.withOpacity(0.78),
                  Colors.white.withOpacity(0.66),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _PlayerIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final bool isPrimary;

  const _PlayerIcon({
    required this.icon,
    required this.onTap,
    this.size = 24,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      splashColor: Colors.white.withOpacity(0.06),
      highlightColor: Colors.white.withOpacity(0.03),
      child: SizedBox(
        height: isPrimary ? 42 : 36,
        width: isPrimary ? 42 : 36,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isPrimary)
              Positioned.fill(
                child: CustomPaint(
                  painter: _VoicemailIconGlowPainter(isDark: isDark),
                ),
              ),

            if (isPrimary)
              Positioned.fill(
                child: ClipOval(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 12,
                      sigmaY: 12,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isDark
                              ? [
                            Colors.white.withOpacity(0.14),
                            Colors.white.withOpacity(0.08),
                            Colors.white.withOpacity(0.05),
                          ]
                              : [
                            Colors.white.withOpacity(0.94),
                            Colors.white.withOpacity(0.78),
                            Colors.white.withOpacity(0.66),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            if (isPrimary)
              Positioned.fill(
                child: CustomPaint(
                  painter: _VoicemailIconBorderPainter(isDark: isDark),
                ),
              ),

            Icon(
              icon,
              size: size,
              color: theme.colorScheme.onSurface.withOpacity(0.92),
            ),
          ],
        ),
      ),
    );
  }
}

class _VoicemailCardOuterGlowPainter extends CustomPainter {
  final bool isDark;
  final double radius;

  const _VoicemailCardOuterGlowPainter({
    required this.isDark,
    required this.radius,
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
      Radius.circular(radius),
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3.4,
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
  bool shouldRepaint(covariant _VoicemailCardOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark || oldDelegate.radius != radius;
  }
}

class _VoicemailCardBorderPainter extends CustomPainter {
  final bool isDark;
  final double radius;

  const _VoicemailCardBorderPainter({
    required this.isDark,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
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
          Colors.white.withOpacity(0.21),
          Colors.white.withOpacity(0.070),
          Colors.black.withOpacity(0.34),
        ]
            : [
          Colors.white.withOpacity(0.90),
          Colors.white.withOpacity(0.43),
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
      const Offset(24, 2.0),
      Offset(size.width - 24, 2.0),
      topShinePaint,
    );

    // Bottom soft edge
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
      Offset(24, size.height - 2.0),
      Offset(size.width - 24, size.height - 2.0),
      bottomEdgePaint,
    );

    // Inner depth
    final innerRect = Rect.fromLTWH(
      4,
      4,
      size.width - 8,
      size.height - 8,
    );

    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      Radius.circular(radius - 2),
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
  bool shouldRepaint(covariant _VoicemailCardBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark || oldDelegate.radius != radius;
  }
}

class _VoicemailIconGlowPainter extends CustomPainter {
  final bool isDark;

  const _VoicemailIconGlowPainter({
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
      ..strokeWidth = 2.2
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
          Colors.black.withOpacity(0.28),
        ]
            : [
          Colors.white.withOpacity(0.80),
          Colors.white.withOpacity(0.30),
          Colors.black.withOpacity(0.06),
        ],
      ).createShader(rect);

    canvas.drawOval(circleRect, paint);
  }

  @override
  bool shouldRepaint(covariant _VoicemailIconGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _VoicemailIconBorderPainter extends CustomPainter {
  final bool isDark;

  const _VoicemailIconBorderPainter({
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
      ).createShader(rect);

    canvas.drawOval(circleRect, borderPaint);

    final topShinePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        0.75,
      )
      ..color = Colors.white.withOpacity(isDark ? 0.18 : 0.55);

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
  }

  @override
  bool shouldRepaint(covariant _VoicemailIconBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}