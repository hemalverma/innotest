import 'package:flutter/material.dart';

class AppTextStyles {
  static TextStyle get title => const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w500,
      );
  static customStyle({
    double? size,
    FontWeight? weight,
    Color? color,
  }) =>
      TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      );

  static TextStyle get subtitle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get body => const TextStyle(
        fontSize: 16,
      );
  static TextStyle get button => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get caption => const TextStyle(
        fontSize: 12,
      );
  static TextStyle get input => const TextStyle(
        fontSize: 16,
      );
  static TextStyle get error => const TextStyle(
        fontSize: 14,
        color: Colors.red,
      );
  static TextStyle get success => const TextStyle(
        fontSize: 14,
        color: Colors.green,
      );
  static TextStyle get link => const TextStyle(
        fontSize: 16,
        color: Colors.blue,
      );
  static TextStyle get label => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get hint => const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      );
  static TextStyle get disabled => const TextStyle(
        fontSize: 16,
        color: Colors.grey,
      );
  static TextStyle get overline => const TextStyle(
        fontSize: 10,
      );
  static TextStyle get headline1 => const TextStyle(
        fontSize: 96,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get headline2 => const TextStyle(
        fontSize: 60,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get headline3 => const TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get headline4 => const TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get headline5 => const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get headline6 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get subtitle1 => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get subtitle2 => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );
  static TextStyle get body1 => const TextStyle(
        fontSize: 16,
      );
  static TextStyle get body2 => const TextStyle(
        fontSize: 14,
      );
}
