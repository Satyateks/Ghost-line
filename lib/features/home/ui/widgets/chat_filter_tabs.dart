// ignore_for_file: unnecessary_underscores

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/theme/theme_route.dart';
import '../../controller/home_controller.dart';

class ChatFilterTabs extends StatelessWidget {
  final HomeController controller;

  const ChatFilterTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 34,
      child: Obx(
            () => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.filterTabs.length + 1,
          separatorBuilder: (_, __) => const SizedBox(width: 7),
          itemBuilder: (context, index) {
            if (index == 0) {
              return _AddTabButton(
                onTap: () => _showAddTabBottomSheet(context, controller),
              );
            }

            final item = controller.filterTabs[index - 1];

            return Obx(() {
              final selected = controller.selectedFilter.value == item.id;

              return _FilterChip(
                title: item.title,
                selected: selected,
                onTap: () => controller.changeFilter(item.id),
              );
            });
          },
        ),
      ),
    );
  }

  void _showAddTabBottomSheet(
      BuildContext context,
      HomeController controller,
      ) {
    final TextEditingController textController = TextEditingController();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;

        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(24),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 15,
                sigmaY: 15,
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.black.withOpacity(0.55)
                      : Colors.white.withOpacity(0.62),
                  border: Border(
                    top: BorderSide(
                      color: Colors.white.withOpacity(0.20),
                      width: 1.2,
                    ),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.24)
                              : Colors.black.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Add New Tab',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Glass TextField
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(
                          sigmaX: 12,
                          sigmaY: 12,
                        ),
                        child: TextField(
                          controller: textController,
                          style: TextStyle(
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          decoration: InputDecoration(
                            hintText: 'e.g. Work, Friends',
                            hintStyle: TextStyle(
                              color: isDark ? Colors.white54 : Colors.black45,
                            ),
                            filled: true,
                            fillColor: isDark
                                ? Colors.white.withOpacity(0.075)
                                : Colors.white.withOpacity(0.70),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: isDark
                                    ? Colors.white.withOpacity(0.16)
                                    : Colors.white.withOpacity(0.75),
                                width: 0.9,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: AppColors.primaryBlue.withOpacity(0.55),
                                width: 1.0,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 14,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: () {
                          if (textController.text.trim().isNotEmpty) {
                            controller.addCustomTab(
                              textController.text.trim(),
                            );
                            Get.back();
                          }
                        },
                        child: const Text(
                          'Add Tab',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AddTabButton extends StatelessWidget {
  final VoidCallback onTap;

  const _AddTabButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 30,
        width: 40,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CustomPaint(
                painter: _ChipOuterGlowPainter(
                  isDark: isDark,
                  selected: false,
                ),
              ),
            ),
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
                          Colors.white.withOpacity(0.86),
                          Colors.white.withOpacity(0.70),
                          Colors.white.withOpacity(0.58),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: CustomPaint(
                painter: _ChipGlassBorderPainter(
                  isDark: isDark,
                  selected: false,
                ),
              ),
            ),
            Icon(
              Icons.add_rounded,
              size: 20,
              color: isDark
                  ? Colors.white.withOpacity(0.78)
                  : Colors.black.withOpacity(0.58),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedScale(
        scale: selected ? 1.02 : 1.0,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: 30,
          constraints: const BoxConstraints(
            minWidth: 54,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _ChipOuterGlowPainter(
                    isDark: isDark,
                    selected: selected,
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
                          colors: selected
                              ? [
                            AppColors.primaryBlue.withOpacity(0.56),
                            AppColors.primaryBlue.withOpacity(0.40),
                            AppColors.primaryBlue.withOpacity(0.28),
                          ]
                              : isDark
                              ? [
                            Colors.white.withOpacity(0.120),
                            Colors.white.withOpacity(0.075),
                            Colors.white.withOpacity(0.050),
                          ]
                              : [
                            Colors.white.withOpacity(0.86),
                            Colors.white.withOpacity(0.70),
                            Colors.white.withOpacity(0.58),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Thin border + top/bottom shine
              Positioned.fill(
                child: CustomPaint(
                  painter: _ChipGlassBorderPainter(
                    isDark: isDark,
                    selected: selected,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: selected
                        ? Colors.white
                        : isDark
                        ? Colors.white.withOpacity(0.72)
                        : Colors.black.withOpacity(0.58),
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChipOuterGlowPainter extends CustomPainter {
  final bool isDark;
  final bool selected;

  const _ChipOuterGlowPainter({
    required this.isDark,
    required this.selected,
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
      ..strokeWidth = selected ? 2.6 : 2.2
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        3.0,
      )
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: selected
            ? [
          AppColors.primaryBlue.withOpacity(0.38),
          Colors.white.withOpacity(0.10),
          Colors.black.withOpacity(isDark ? 0.30 : 0.08),
        ]
            : isDark
            ? [
          Colors.white.withOpacity(0.12),
          Colors.white.withOpacity(0.035),
          Colors.black.withOpacity(0.28),
        ]
            : [
          Colors.white.withOpacity(0.78),
          Colors.white.withOpacity(0.28),
          Colors.black.withOpacity(0.07),
        ],
        stops: const [0.0, 0.45, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _ChipOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.selected != selected;
  }
}

class _ChipGlassBorderPainter extends CustomPainter {
  final bool isDark;
  final bool selected;

  const _ChipGlassBorderPainter({
    required this.isDark,
    required this.selected,
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
      ..strokeWidth = selected ? 1.05 : 0.9
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: selected
            ? [
          Colors.white.withOpacity(0.34),
          AppColors.primaryBlue.withOpacity(0.28),
          Colors.black.withOpacity(isDark ? 0.32 : 0.10),
        ]
            : isDark
            ? [
          Colors.white.withOpacity(0.22),
          Colors.white.withOpacity(0.075),
          Colors.black.withOpacity(0.32),
        ]
            : [
          Colors.white.withOpacity(0.85),
          Colors.white.withOpacity(0.42),
          Colors.black.withOpacity(0.08),
        ],
        stops: const [0.0, 0.48, 1.0],
      ).createShader(rect);

    canvas.drawRRect(rrect, borderPaint);

    // Top shine
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
          Colors.white.withOpacity(selected ? 0.16 : isDark ? 0.10 : 0.34),
          Colors.white.withOpacity(selected ? 0.32 : isDark ? 0.18 : 0.62),
          Colors.white.withOpacity(selected ? 0.14 : isDark ? 0.08 : 0.28),
          Colors.white.withOpacity(0.00),
        ],
        stops: const [0.0, 0.22, 0.50, 0.78, 1.0],
      ).createShader(rect);

    canvas.drawLine(
      Offset(radius + 8, 1.8),
      Offset(size.width - radius - 8, 1.8),
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
        colors: selected
            ? [
          Colors.white.withOpacity(0.00),
          Colors.black.withOpacity(0.08),
          Colors.black.withOpacity(0.16),
          Colors.black.withOpacity(0.08),
          Colors.white.withOpacity(0.00),
        ]
            : isDark
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
      Offset(radius + 8, size.height - 1.8),
      Offset(size.width - radius - 8, size.height - 1.8),
      bottomEdgePaint,
    );

    // Inner depth
    final innerRect = Rect.fromLTWH(
      3,
      3,
      size.width - 6,
      size.height - 6,
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
      ..color = selected
          ? Colors.black.withOpacity(0.16)
          : isDark
          ? Colors.black.withOpacity(0.20)
          : Colors.white.withOpacity(0.24);

    canvas.drawRRect(innerRRect, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant _ChipGlassBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark ||
        oldDelegate.selected != selected;
  }
}