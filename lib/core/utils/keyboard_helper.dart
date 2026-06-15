import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeyboardHelper {
  KeyboardHelper._();

  static void hide() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static bool get isOpen {
    final context = Get.context;
    if (context == null) return false;

    return MediaQuery.of(context).viewInsets.bottom > 0;
  }

  static double get height {
    final context = Get.context;
    if (context == null) return 0;

    return MediaQuery.of(context).viewInsets.bottom;
  }

  static EdgeInsets bottomInset({double extra = 0}) {
    final context = Get.context;
    if (context == null) return EdgeInsets.only(bottom: extra);

    return EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom + extra,
    );
  }
}
