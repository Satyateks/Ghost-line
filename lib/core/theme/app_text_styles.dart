import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Inter';

  static TextStyle h1(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 28,
    height: 1.15,
    fontWeight: FontWeight.w800,
    color: color,
    letterSpacing: -0.4,
  );

  static TextStyle h2(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    height: 1.18,
    fontWeight: FontWeight.w800,
    color: color,
    letterSpacing: -0.3,
  );

  static TextStyle h3(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    height: 1.22,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle authTitle(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    height: 1.2,
    fontWeight: FontWeight.w800,
    color: color,
    letterSpacing: -0.2,
  );

  static TextStyle authInput(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12.5,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle authHint(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 11.5,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle bodyLarge(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle bodyMedium(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    height: 1.4,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle bodySmall(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    height: 1.35,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle button(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: color,
  );

  static TextStyle buttonLarge(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle chatName(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: color,
  );

  static TextStyle chatMessage(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 13,
    height: 1.35,
    fontWeight: FontWeight.w500,
    color: color,
  );

  static TextStyle chatTime(Color color) => TextStyle(
    fontFamily: fontFamily,
    fontSize: 10.5,
    fontWeight: FontWeight.w500,
    color: color,
  );
}
