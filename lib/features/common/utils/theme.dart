import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../lib.dart';

class QuranifyTheme {
  ThemeData of(BuildContext context) {
    final theme = Theme.of(context);

    return theme.copyWith(
      primaryColor: AppColors.brand,
      scaffoldBackgroundColor: AppColors.n50,
      shadowColor: AppColors.n300,
      disabledColor: AppColors.n400,
      colorScheme: theme.colorScheme.copyWith(
        primary: AppColors.brand,
        secondary: AppColors.sky,
        error: AppColors.error,
        surface: Colors.white,
      ),

      iconTheme: theme.iconTheme.copyWith(color: AppColors.ink),

      floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
        backgroundColor: AppColors.brand,
        foregroundColor: Colors.white,
      ),

      appBarTheme: theme.appBarTheme.copyWith(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),

      cardTheme: theme.cardTheme.copyWith(
        elevation: 1,
        shadowColor: AppColors.n300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(12),
        ),
      ),

      dividerTheme: theme.dividerTheme.copyWith(color: AppColors.n200),

      inputDecorationTheme: theme.inputDecorationTheme.copyWith(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),

        hintStyle: GoogleFonts.inter(color: AppColors.n500, fontSize: 14),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.brand),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.brand, width: 2),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.error),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.brand,
          foregroundColor: Colors.white,
          minimumSize: Size(double.infinity, 52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(12),
          ),
        ),
      ),

      splashColor: (kIsWeb || Platform.isAndroid)
          // ignore: deprecated_member_use
          ? AppColors.brand.withOpacity(0.08)
          : Colors.transparent,

      highlightColor: (!kIsWeb && Platform.isAndroid)
          ? Colors.transparent
          // ignore: deprecated_member_use
          : AppColors.brand.withOpacity(0.08),

      textTheme: theme.textTheme.copyWith().apply(
        fontFamily: GoogleFonts.alatsi().fontFamily,
      ),
    );
  }
}
