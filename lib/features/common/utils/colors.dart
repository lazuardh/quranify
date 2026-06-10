import 'package:flutter/material.dart';

class AppColors {
  // Primary
  static const brand = Color(0xFF0B101B);
  static const brandLight = Color(0xFF132238);
  static const brandDark = Color(0xFF060B14);
  static const brandTint = Color(0xFF1A2940);

  // Secondary
  static const secondary = Color(0xFF8B5CF6);
  static const secondaryLight = Color(0xFFA78BFA);
  static const secondaryDark = Color(0xFF6D28D9);

  // Accent
  static const tertiary = Color(0xFFF59E0B);
  static const tertiaryLight = Color(0xFFFBBF24);
  static const tertiaryDark = Color(0xFFD97706);

  // Surface
  static const surface = Color(0xFF132238);
  static const surfaceVariant = Color(0xFF1B2A41);

  // Text
  static const ink = Color(0xFFF8FAFC);
  static const inkSoft = Color(0xFFCBD5E1);

  // Semantic
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);

  // Neutral
  static const n50 = Color(0xFFF8FAFC);
  static const n100 = Color(0xFFE2E8F0);
  static const n200 = Color(0xFFCBD5E1);
  static const n300 = Color(0xFF94A3B8);
  static const n400 = Color(0xFF64748B);
  static const n500 = Color(0xFF475569);
  static const n600 = Color(0xFF334155);
  static const n700 = Color(0xFF1E293B);
  static const n800 = Color(0xFF0F172A);
}

class TextFieldColors {
  static const text = AppColors.ink;

  static const hint = AppColors.n300;

  static const label = AppColors.n200;

  static const enabledBorder = AppColors.n500;

  static const focusedBorder = AppColors.secondary;

  static const errorBorder = AppColors.error;

  static const fill = AppColors.surface;

  static const disabled = AppColors.n400;
}
