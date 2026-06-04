import 'package:flutter/material.dart';

class AppColors {
  // Brand
  static const brand = Color(0xFF6C63FF);
  static const brandLight = Color(0xFF857DFF);
  static const brandDark = Color(0xFF4C44CC);
  static const brandTint = Color(0xFFEEECFF);

  // Accent
  static const ink = Color(0xFF0F172A);
  static const inkSoft = Color(0xFF1E293B);
  static const sky = Color(0xFF38BDF8);
  static const violet = Color(0xFFA78BFA);

  // Semantic
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
  static const error = Color(0xFFEF4444);

  // Neutral
  static const n50 = Color(0xFFF8FAFC);
  static const n100 = Color(0xFFF1F5F9);
  static const n200 = Color(0xFFE2E8F0);
  static const n300 = Color(0xFFCBD5E1);
  static const n400 = Color(0xFF94A3B8);
  static const n500 = Color(0xFF64748B);
  static const n600 = Color(0xFF475569);
  static const n700 = Color(0xFF334155);
  static const n800 = Color(0xFF1E293B);
}

class TextFieldColors {
  /// Text yang diketik user
  static const text = AppColors.ink;

  /// Placeholder / Hint
  static const hint = AppColors.n500;

  /// Label normal
  static const label = AppColors.n600;

  /// Border normal
  static const enabledBorder = AppColors.n300;

  /// Border saat focus
  static const focusedBorder = AppColors.brand;

  /// Border error
  static const errorBorder = AppColors.error;

  /// Background TextField
  static const fill = Colors.white;

  /// Disabled
  static const disabled = AppColors.n400;
}
