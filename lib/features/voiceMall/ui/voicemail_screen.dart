
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/glass_scaffold.dart';
import '../../home/controller/home_controller.dart';
import '../../home/ui/widgets/main_bottom_nav.dart';
import '../controller/voicemail_controller.dart';
import 'voicemail_detail_screen.dart';
import 'voicemail_greetings_screen.dart';
import 'widgets/voicemail_tile.dart';

class VoicemailScreen extends StatelessWidget {
  VoicemailScreen({super.key});

  final VoicemailController controller = Get.put(VoicemailController());
  final HomeController homeCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // return Scaffold( backgroundColor: theme.scaffoldBackgroundColor,
     return GlassScaffold(
      safeArea: true, resizeToAvoidBottomInset: true,
      bottomNavigationBar: MainBottomNav(controller: homeCtrl),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 12, 8, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: Stack(
                          children: [
                            // Soft outer glow
                            Positioned.fill(
                              child: CustomPaint(
                                painter: _MiniSearchOuterGlowPainter(
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
                                    sigmaX: 15,
                                    sigmaY: 15,
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
                                painter: _MiniSearchGlassBorderPainter(
                                  isDark: isDark,
                                  primaryColor: theme.colorScheme.primary,
                                ),
                              ),
                            ),

                            // TextField
                            Positioned.fill(
                              child: TextField(
                                controller: controller.searchController,
                                cursorColor: theme.colorScheme.primary,
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  filled: false,
                                  prefixIcon: Icon(
                                    Icons.search_rounded,
                                    size: 20,
                                    color: theme.colorScheme.onSurface.withOpacity(0.56),
                                  ),
                                  hintText: "Search name, numbers",
                                  hintStyle: TextStyle(
                                    color: theme.colorScheme.onSurface.withOpacity(0.52),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                    right: 12,
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
                    ),
      
                    const SizedBox(width: 10),

                    GestureDetector(
                      onTap: () => Get.to(() => VoicemailGreetingsScreen()),
                      child: CustomPaint(
                        painter: _GreetingPillOuterGlowPainter(
                          isDark: isDark,
                        ),
                        foregroundPainter: _GreetingPillBorderPainter(
                          isDark: isDark,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(999),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 14,
                              sigmaY: 14,
                            ),
                            child: Container(
                              height: 40,
                              padding: const EdgeInsets.symmetric(horizontal: 18),
                              alignment: Alignment.center,
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
                              child: Text(
                                "Greetings",
                                style: TextStyle(
                                  color: theme.colorScheme.onSurface.withOpacity(0.92),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      
              Expanded(
                child: Obx(
                  () => ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(8, 18, 8, 96),
                    children: [
                      if (controller.recentVoicemails.isNotEmpty) ...[
                        _SectionTitle(title: "Recents"),
                        const SizedBox(height: 6),
                        ...controller.recentVoicemails.map((item) => VoicemailTile(voicemail: item, onTap: () =>Get.to(VoicemailDetailScreen(), arguments: item)))],
      
                      if (controller.olderVoicemails.isNotEmpty) ...[
                        const SizedBox(height: 18),
                        _SectionTitle(title: "Older"),
                        const SizedBox(height: 6),
                        ...controller.olderVoicemails.map((item) => VoicemailTile(voicemail: item, onTap: () =>Get.to(VoicemailDetailScreen(), arguments: item)))],
      
                      if (controller.filteredVoicemails.isEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 120),
                          child: Center(
                            child: Text(
                              "No voicemail found",
                              style: TextStyle(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
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
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
class _MiniSearchOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _MiniSearchOuterGlowPainter({
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
  bool shouldRepaint(covariant _MiniSearchOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _MiniSearchGlassBorderPainter extends CustomPainter {
  final bool isDark;
  final Color primaryColor;

  const _MiniSearchGlassBorderPainter({
    required this.isDark,
    required this.primaryColor,
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
      Offset(radius + 16, 1.9),
      Offset(size.width - radius - 16, 1.9),
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
      Offset(radius + 16, size.height - 1.9),
      Offset(size.width - radius - 16, size.height - 1.9),
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
  bool shouldRepaint(covariant _MiniSearchGlassBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.primaryColor != primaryColor;
  }
}
class _GreetingPillOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _GreetingPillOuterGlowPainter({
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
  bool shouldRepaint(covariant _GreetingPillOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _GreetingPillBorderPainter extends CustomPainter {
  final bool isDark;

  const _GreetingPillBorderPainter({
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
      Offset(radius + 10, 1.9),
      Offset(size.width - radius - 10, 1.9),
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
      Offset(radius + 10, size.height - 1.9),
      Offset(size.width - radius - 10, size.height - 1.9),
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
  bool shouldRepaint(covariant _GreetingPillBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
