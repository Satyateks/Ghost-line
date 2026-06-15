import 'package:flutter/material.dart';
import 'app_constants.dart';

class Responsive {
  Responsive._();

  static Size size(BuildContext context) => MediaQuery.sizeOf(context);

  static double width(BuildContext context) => size(context).width;

  static double height(BuildContext context) => size(context).height;

  static double statusBarHeight(BuildContext context) {return MediaQuery.paddingOf(context).top;}

  static double bottomPadding(BuildContext context) {return MediaQuery.paddingOf(context).bottom;}

  static double keyboardHeight(BuildContext context) {return MediaQuery.viewInsetsOf(context).bottom;}

  static bool isKeyboardOpen(BuildContext context) {return keyboardHeight(context) > 0;}

  static bool isSmallPhone(BuildContext context) {return width(context) < 360;}

  static bool isMobile(BuildContext context) {
    return width(context) < 600;
  }

  static bool isTablet(BuildContext context) {
    return width(context) >= 600 && width(context) < 1024;
  }

  static bool isDesktop(BuildContext context) {
    return width(context) >= 1024;
  }

  /// Width scale according to Figma design width.
  static double w(BuildContext context, double value) {
    return value * width(context) / AppConstants.designWidth;
  }

  /// Height scale according to Figma design height.
  static double h(BuildContext context, double value) {
    return value * height(context) / AppConstants.designHeight;
  }

  /// Font scale, controlled to avoid too large/small text.
  static double sp(BuildContext context, double value) {
    final scale = width(context) / AppConstants.designWidth;
    return value * scale.clamp(0.90, 1.12);
  }

  static EdgeInsets screenPadding(BuildContext context) {
    final horizontal = isSmallPhone(context) ? 16.0 : 20.0;

    return EdgeInsets.symmetric(horizontal: horizontal, vertical: 16);
  }

  static double authCardTop(BuildContext context) {
    final h = height(context);

    if (h < 700) return h * 0.50;
    if (h < 780) return h * 0.54;
    return h * 0.58;
  }
}
