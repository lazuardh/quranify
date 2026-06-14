import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../lib.dart';

class QuranifyTheme {
  ThemeData of(BuildContext context) {
    final theme = Theme.of(context);

    return theme.copyWith(
      // Background
      scaffoldBackgroundColor: AppColors.brand,

      // Color Scheme
      colorScheme: theme.colorScheme.copyWith(
        primary: AppColors.brand,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        error: AppColors.error,
        surface: AppColors.surface,
        onPrimary: AppColors.ink,
        onSecondary: Colors.white,
        onSurface: AppColors.ink,
      ),

      // General Colors
      primaryColor: AppColors.brand,
      shadowColor: AppColors.n800,
      disabledColor: AppColors.n400,

      // Icons
      iconTheme: const IconThemeData(color: AppColors.inkSoft, size: 24),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.brand,
        foregroundColor: AppColors.ink,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),

      // Cards
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.n600),
        ),
      ),

      // Divider
      dividerTheme: const DividerThemeData(color: AppColors.n600),

      // Text Field
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: TextFieldColors.fill,

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        hintStyle: GoogleFonts.sora(color: TextFieldColors.hint, fontSize: 14),

        labelStyle: GoogleFonts.sora(
          color: TextFieldColors.label,
          fontSize: 14,
        ),

        prefixIconColor: TextFieldColors.hint,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: TextFieldColors.enabledBorder),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: TextFieldColors.focusedBorder,
            width: 2,
          ),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: TextFieldColors.errorBorder),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: TextFieldColors.errorBorder, width: 2),
        ),
      ),

      // Elevated Button (Primary)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 52),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.secondary,
        linearTrackColor: AppColors.n600,
        circularTrackColor: AppColors.n600,
        borderRadius: BorderRadius.circular(10),
      ),

      // Outlined Button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.ink,
          side: const BorderSide(color: AppColors.n500),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.secondary,
        foregroundColor: Colors.white,
      ),

      dialogTheme: theme.dialogTheme.copyWith(
        backgroundColor: AppColors.ink,
        elevation: 0,
        insetPadding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        titleTextStyle: AppTextStyle.medium.copyWith(
          color: Colors.white,
          fontSize: 18,
        ),
        contentTextStyle: AppTextStyle.regular.copyWith(
          color: Colors.white70,
          fontSize: 14,
        ),
      ),

      // Ripple
      splashColor: AppColors.secondary.withValues(alpha: 0.12),

      highlightColor: Colors.transparent,

      bottomNavigationBarTheme: theme.bottomNavigationBarTheme.copyWith(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.shifting,
      ),

      // Typography
      textTheme: GoogleFonts.soraTextTheme(theme.textTheme).copyWith(
        headlineLarge: GoogleFonts.sora(
          color: AppColors.ink,
          fontWeight: FontWeight.w700,
        ),

        bodyLarge: GoogleFonts.sora(color: AppColors.ink),

        bodyMedium: GoogleFonts.sora(color: AppColors.inkSoft),

        labelMedium: GoogleFonts.sora(color: AppColors.n300),
      ),
    );
  }
}
