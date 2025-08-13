import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color deepViolet = Color(0xFF360167);
  static const Color patriarch = Color(0xFF6B0772);
  static const Color mediumVioletRed = Color(0xFFAF1281);
  static const Color royalFuchsia = Color(0xFFCF268A);
  static const Color raspberryPink = Color(0xFFE65C9C);
  static const Color flamingoPink = Color(0xFFFB8CAB);

  // Accent colors
  static const Color positive = Color(0xFF8AE234);
  static const Color warning = Color(0xFFFFC300);
  static const Color alert = Color(0xFFE91C4C);
  static const Color neutral = Color(0xFFF4E1FF);

  // Additional named variants for clarity
  static const Color positiveGreen = Color(0xFF8AE234); // same as positive
  static const Color warningYellow = Color(0xFFFFC300); // same as warning

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepViolet, royalFuchsia, flamingoPink],
  );

  static const LinearGradient trainerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [patriarch, mediumVioletRed, raspberryPink],
  );

  static const LinearGradient ownerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [deepViolet, mediumVioletRed, flamingoPink],
  );
}
