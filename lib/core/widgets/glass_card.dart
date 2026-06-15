import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_radius.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final double blur;
  final double? width;
  final double? height;
  final Color? color;
  final Color? borderColor;
  final bool showShadow;
  final VoidCallback? onTap;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.radius = AppRadius.xl,
    this.blur = 18,
    this.width,
    this.height,
    this.color,
    this.borderColor,
    this.showShadow = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final glassColor = color ??
        (isDark
            ? Colors.white.withOpacity(0.075)
            : Colors.white.withOpacity(0.72));

    final glassBorder = borderColor ??
        (isDark
            ? Colors.white.withOpacity(0.10)
            : Colors.white.withOpacity(0.95));

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blur,
          sigmaY: blur,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(radius),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            decoration: BoxDecoration(
              color: glassColor,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: glassBorder),
              boxShadow: showShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(isDark ? 0.28 : 0.08),
                        blurRadius: 28,
                        offset: const Offset(0, 14),
                      ),
                    ]
                  : null,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}