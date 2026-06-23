import 'package:flutter/material.dart';

class AppRadius {
  AppRadius._();

  static const double xs = 6;
  static const double sm = 10;
  static const double md = 14;
  static const double lg = 18;
  static const double xl = 24;
  static const double xxl = 30;
  static const double xxll = 80;
  static const double full = 999;

  /// Auth UI
  static const double authCard = 26;
  static const double authField = 22;
  static const double authButton = 22;

  /// Chat UI
  static const double chatBubble = 20;
  static const double messageInput = 24;
  static const double avatar = 999;

  /// Premium UI
  static const double premiumCard = 22;
  static const double planChip = 18;

  static BorderRadius radius(double value) {return BorderRadius.circular(value);}

  static BorderRadius get xsRadius => BorderRadius.circular(xs);
  static BorderRadius get smRadius => BorderRadius.circular(sm);
  static BorderRadius get mdRadius => BorderRadius.circular(md);
  static BorderRadius get lgRadius => BorderRadius.circular(lg);
  static BorderRadius get xlRadius => BorderRadius.circular(xl);
  static BorderRadius get xxlRadius => BorderRadius.circular(xxl);
  static BorderRadius get xxllRadius => BorderRadius.circular(xxll);
  static BorderRadius get fullRadius => BorderRadius.circular(full);

  static const BorderRadius authCardRadius = BorderRadius.all(Radius.circular(authCard));
  static const BorderRadius bottomSheetRadius = BorderRadius.vertical(top: Radius.circular(xxl));
}