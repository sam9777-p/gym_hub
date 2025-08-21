import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(),
    cardTheme: const CardThemeData(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    // Use a deep, dark background color
    scaffoldBackgroundColor: const Color(0xFF121212),
    cardColor: const Color(0xFF1E1E1E),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.royalFuchsia,
      brightness: Brightness.dark,
      // Define a custom color scheme for dark mode
      primary: AppColors.royalFuchsia,
      onPrimary: Colors.white,
      secondary: AppColors.flamingoPink,
      onSecondary: Colors.white,
      surface: const Color(0xFF1E1E1E),
      onSurface: Colors.white,
      background: const Color(0xFF121212),
      onBackground: Colors.white,
      error: const Color(0xFFCF6679),
      onError: Colors.white,
    ),
    useMaterial3: true,
    textTheme: GoogleFonts.poppinsTextTheme(
      ThemeData.dark().textTheme,
    ),
    cardTheme: const CardThemeData(
      elevation: 4,
      shadowColor: Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );
}