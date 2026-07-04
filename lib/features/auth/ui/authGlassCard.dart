import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/theme/theme_route.dart';

class AuthGlassCard extends StatelessWidget {
  final Widget child;

  const AuthGlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return CustomPaint(
      painter: ProfileHeaderOuterGlowPainter(isDark: isDark),
      foregroundPainter: ProfileHeaderBorderPainter(isDark: isDark),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 21, sigmaY: 21),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 21, 12, 21),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.12)
                  : Colors.white.withOpacity(0.82),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark
                    ? Colors.white.withOpacity(0.12)
                    : Colors.white.withOpacity(0.95),
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class ProfileHeaderOuterGlowPainter extends CustomPainter {
  final bool isDark;

  const ProfileHeaderOuterGlowPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 24.0;
    final rect = Rect.fromLTWH(1.5, 1.5, size.width - 3, size.height - 3);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3.6)
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
  bool shouldRepaint(covariant ProfileHeaderOuterGlowPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}

class ProfileHeaderBorderPainter extends CustomPainter {
  final bool isDark;

  const ProfileHeaderBorderPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    const radius = 24.0;

    final rect = Rect.fromLTWH(1, 1, size.width - 2, size.height - 2);

    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(radius));

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
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.85)
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
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 0.85)
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
    final innerRect = Rect.fromLTWH(4, 4, size.width - 8, size.height - 8);

    final innerRRect = RRect.fromRectAndRadius(
      innerRect,
      const Radius.circular(radius - 2),
    );

    final innerShadowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.1)
      ..color = isDark
          ? Colors.black.withOpacity(0.20)
          : Colors.white.withOpacity(0.24);

    canvas.drawRRect(innerRRect, innerShadowPaint);
  }

  @override
  bool shouldRepaint(covariant ProfileHeaderBorderPainter oldDelegate) {
    return oldDelegate.isDark != isDark;
  }
}


class AuthTitle extends StatelessWidget {
  final String title;

  const AuthTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Text(
      title,
      style: AppTextStyles.authTitle(
        isDark ? Colors.white : AppColors.lightTextPrimary,
      ).copyWith(fontSize: 24, fontWeight: FontWeight.w700),
    );
  }
}

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;

  const AuthField({
    required this.controller,
    required this.hint,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : AppColors.lightTextPrimary;
    final hintColor = isDark
        ? Colors.white.withOpacity(0.44)
        : AppColors.lightTextMuted;
    final fieldBgColor = isDark
        ? Colors.white.withOpacity(0.08)
        : AppColors.lightBorder.withOpacity(0.5);

    return SizedBox(
      height: 45,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: AppColors.primaryBlue,
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 14.7,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: fieldBgColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 0,
          ),
          border: _fieldBorder(
            color: isDark ? Colors.transparent : AppColors.lightBorder,
          ),
          enabledBorder: _fieldBorder(
            color: isDark ? Colors.transparent : AppColors.lightBorder,
          ),
          focusedBorder: _fieldBorder(
            color: AppColors.primaryBlue.withOpacity(0.65),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _fieldBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.full),
      borderSide: BorderSide(color: color ?? Colors.transparent, width: 1),
    );
  }
}
