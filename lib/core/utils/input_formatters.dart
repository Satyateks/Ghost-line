import 'package:flutter/services.dart';

class AppInputFormatters {
  AppInputFormatters._();

  static final digitsOnly = FilteringTextInputFormatter.digitsOnly;

  static final noSpaces = FilteringTextInputFormatter.deny(RegExp(r'\s'));

  static final username = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_]'));

  static final name = FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'));

  static final amount = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));

  static LengthLimitingTextInputFormatter maxLength(int length) {return LengthLimitingTextInputFormatter(length);}

  static List<TextInputFormatter> mobile() {return [digitsOnly, maxLength(10)];}

  static List<TextInputFormatter> otp({int length = 6}) {return [digitsOnly, maxLength(length)];}

  static List<TextInputFormatter> usernameFormatter() { return [username, maxLength(20)];}
}


