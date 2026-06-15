import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DeviceHelper {
  DeviceHelper._();

  static bool get isWeb => kIsWeb;

  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  static bool get isIOS => !kIsWeb && Platform.isIOS;

  static bool get isMobile => isAndroid || isIOS;

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).shortestSide >= 600;
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }

  static double pixelRatio(BuildContext context) {
    return MediaQuery.devicePixelRatioOf(context);
  }

  static double textScale(BuildContext context) {
    return MediaQuery.textScalerOf(context).scale(1);
  }

  static bool isSmallHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height < 700;
  }
}