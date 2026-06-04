import 'package:flutter/material.dart';

import '../../../lib.dart';

class AppFontWeight {
  static const FontWeight light = FontWeight.w300;

  static const FontWeight regular = FontWeight.w400;

  static const FontWeight medium = FontWeight.w500;

  static const FontWeight semiBold = FontWeight.w600;

  static const FontWeight bold = FontWeight.w700;

  static const FontWeight extraBold = FontWeight.w800;

  static const FontWeight black = FontWeight.w900;
}

class AppTextStyle {
  /// FontWeight.w300

  static const TextStyle light = TextStyle(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.light,
  );

  /// FontWeight.w400
  static const TextStyle regular = TextStyle(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.regular,
  );

  /// FontWeight.w500
  static const TextStyle medium = TextStyle(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.medium,
  );

  /// FontWeight.w600
  static const TextStyle semiBold = TextStyle(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.semiBold,
  );

  /// FontWeight.w700
  static const TextStyle bold = TextStyle(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.bold,
  );

  /// FontWeight.w800
  static const TextStyle extraBold = TextStyle(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.extraBold,
  );

  /// FontWeight.w900
  static const TextStyle black = TextStyle(
    fontSize: AppFontSize.normal,
    fontWeight: AppFontWeight.black,
  );
}
