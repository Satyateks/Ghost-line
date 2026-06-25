import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/theme_route.dart';
import '../../controller/chat_room_controller.dart';

class MessageInputBar extends StatelessWidget {
  final ChatRoomController controller;

  const MessageInputBar({
    super.key,
    required this.controller,
  });

  void _showAttachmentBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      // backgroundColor: Colors.transparent,
      // barrierColor: Colors.black.withOpacity(0.55),
      isScrollControlled: true,
      builder: (context) {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Stack(
            alignment: Alignment.topCenter,
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 56, 10, 22),
                child: CustomPaint(
                  painter: _AttachmentPanelOuterGlowPainter(isDark: isDark),
                  foregroundPainter: _AttachmentPanelBorderPainter(isDark: isDark),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(21),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 24,
                        sigmaY: 24,
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(0, 26, 0, 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
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
                              Colors.white.withOpacity(0.92),
                              Colors.white.withOpacity(0.76),
                              Colors.white.withOpacity(0.64),
                            ],
                          ),
                        ),
                        child: GridView.count(
                          crossAxisCount: 3,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          childAspectRatio: 1.35,
                          children: [
                            _AttachmentItem(
                              icon: Icons.camera_alt_outlined,
                              label: 'Camera',
                              onTap: () {
                                Navigator.pop(context);
                                controller.pickImage(ImageSource.camera);
                              },
                            ),
                            _AttachmentItem(
                              icon: Icons.image_outlined,
                              label: 'Photos',
                              onTap: () {
                                Navigator.pop(context);
                                controller.pickImage(ImageSource.gallery);
                              },
                            ),
                            _AttachmentItem(
                              icon: Icons.graphic_eq_rounded,
                              label: 'Audio',
                              onTap: () {
                                Navigator.pop(context);
                                // controller.pickAudio();
                              },
                            ),
                            _AttachmentItem(
                              icon: Icons.description_outlined,
                              label: 'Documents',
                              onTap: () {
                                Navigator.pop(context);
                                controller.pickDocument();
                              },
                            ),
                            _AttachmentItem(
                              icon: Icons.graphic_eq_rounded,
                              label: 'Audio',
                              onTap: () {
                                Navigator.pop(context);
                                // controller.pickAudio();
                              },
                            ),
                            _AttachmentItem(
                              icon: Icons.image_outlined,
                              label: 'Photos',
                              onTap: () {
                                Navigator.pop(context);
                                controller.pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 0,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        height: 46,
                        width: 46,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.18),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.26),
                          ),
                        ),
                        child: const Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 24,
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



  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 6, 8, 10),
        child: Row(
          children: [
            _CircleActionButton(
              icon: Icons.add_rounded,
              onTap: () => _showAttachmentBottomSheet(context),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: SizedBox(
                height: 44,
                child: Stack(
                  children: [
                    // Soft outer glow
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _MessageInputOuterGlowPainter(
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
                        painter: _MessageInputBorderPainter(
                          isDark: isDark,
                        ),
                      ),
                    ),

                    // Input content
                    Positioned.fill(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.messageCtrl,
                              cursorColor: AppColors.buttonBlue,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Write your message',
                                hintStyle: TextStyle(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.52)
                                      : Colors.black.withOpacity(0.38),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              onSubmitted: (_) => controller.sendMessage(),
                            ),
                          ),

                          Obx(() {
                            if (controller.isTyping.value) {
                              return InkWell(
                                onTap: controller.sendMessage,
                                borderRadius: BorderRadius.circular(999),
                                splashColor: Colors.white.withOpacity(0.06),
                                highlightColor: Colors.white.withOpacity(0.03),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 8,
                                    right: 14,
                                  ),
                                  child: Icon(
                                    Icons.send_rounded,
                                    color: AppColors.buttonBlue,
                                    size: 23,
                                  ),
                                ),
                              );
                            }

                            final isRecording = controller.isRecording.value;

                            return InkWell(
                              onTap: controller.toggleRecording,
                              borderRadius: BorderRadius.circular(999),
                              splashColor: Colors.white.withOpacity(0.06),
                              highlightColor: Colors.white.withOpacity(0.03),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 8,
                                  right: 14,
                                ),
                                child: Icon(
                                  isRecording
                                      ? Icons.stop_circle_rounded
                                      : Icons.mic_none_rounded,
                                  color: isRecording ? Colors.red : textColor,
                                  size: 23,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleActionButton({
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
                painter: _CircleActionOuterGlowPainter(
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
                painter: _CircleActionBorderPainter(
                  isDark: isDark,
                ),
              ),
            ),

            Icon(
              icon,
              size: 24,
              color: isDark
                  ? Colors.white.withOpacity(0.92)
                  : Colors.black.withOpacity(0.72),
            ),
          ],
        ),
      ),
    );
  }
}
class _CircleActionOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _CircleActionOuterGlowPainter({
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
  bool shouldRepaint(covariant _CircleActionOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _CircleActionBorderPainter extends CustomPainter {
  final bool isDark;

  const _CircleActionBorderPainter({
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
  bool shouldRepaint(covariant _CircleActionBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
class _AttachmentItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _AttachmentItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: const Color(0xFF0A84FF).withOpacity(0.15),
        highlightColor: Colors.white.withOpacity(0.04),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.42),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    color: const Color(0xFF0A84FF),
                    size: 29,
                  ),

                  const SizedBox(height: 9),

                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class _AttachmentPanelOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _AttachmentPanelOuterGlowPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 21.0;

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
  bool shouldRepaint(covariant _AttachmentPanelOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _AttachmentPanelBorderPainter extends CustomPainter {
  final bool isDark;

  const _AttachmentPanelBorderPainter({
    required this.isDark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 21.0;

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
      const Offset(28, 2.0),
      Offset(size.width - 28, 2.0),
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
      Offset(28, size.height - 2.0),
      Offset(size.width - 28, size.height - 2.0),
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
  bool shouldRepaint(covariant _AttachmentPanelBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}
class _MessageInputOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const _MessageInputOuterGlowPainter({
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
  bool shouldRepaint(covariant _MessageInputOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class _MessageInputBorderPainter extends CustomPainter {
  final bool isDark;

  const _MessageInputBorderPainter({
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
  bool shouldRepaint(covariant _MessageInputBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}