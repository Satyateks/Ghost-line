import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/glass_scaffold.dart';
import '../../home/controller/home_controller.dart';
import '../../home/ui/widgets/main_bottom_nav.dart';
import '../controller/calls_controller.dart';
import 'widgets/call_list_tile.dart';
import 'widgets/calls_search_bar.dart';
import 'widgets/floating_call_button.dart';

class CallsScreen extends StatelessWidget {
  CallsScreen({super.key});

  final CallsController callsCtrl = Get.put(CallsController());
  final HomeController homeCtrl = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    homeCtrl.selectedBottomTab.value = BottomTabType.calls;

    return GlassScaffold(
      safeArea: true,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: MainBottomNav(controller: homeCtrl),
      floatingActionButton: const FloatingCallButton(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),

          _CallsHeader(),

          const SizedBox(height: 14),

          CallsSearchBar(onChanged: callsCtrl.updateSearch),

          const SizedBox(height: 20),

          Expanded(
            child: Obx(
              () => ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 96),
                children: [
                  _SectionTitle('Recents'),
                  const SizedBox(height: 8),

                  ...callsCtrl.recentCalls.map((call) => CallListTile(call: call)),

                  const SizedBox(height: 14),

                  _SectionTitle('Contacts'),
                  const SizedBox(height: 8),

                  ...callsCtrl.contacts.map((call) => CallListTile(call: call)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CallsHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          InkWell(
            onTap: Get.back,
            borderRadius: BorderRadius.circular(999),
            splashColor: Colors.white.withOpacity(0.06),
            highlightColor: Colors.white.withOpacity(0.03),
            child: SizedBox(
              height: 40,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Soft outer glow
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _HeaderGlassOuterGlowPainter(
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
                          sigmaX: 14,
                          sigmaY: 14,
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
                      painter: _HeaderGlassBorderPainter(
                        isDark: isDark,
                      ),
                    ),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 15,
                          color: isDark
                              ? Colors.white.withOpacity(0.92)
                              : AppColors.lightTextPrimary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Calls',
                          style: TextStyle(
                            color: isDark
                                ? Colors.white.withOpacity(0.94)
                                : AppColors.lightTextPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderGlassOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _HeaderGlassOuterGlowPainter({
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
        3.1,
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
  bool shouldRepaint(covariant _HeaderGlassOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _HeaderGlassBorderPainter extends CustomPainter {
  final bool isDark;

  const _HeaderGlassBorderPainter({
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
  bool shouldRepaint(covariant _HeaderGlassBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.white : AppColors.lightTextPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

