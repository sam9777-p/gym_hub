import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color deepViolet = Color(0xFF360167);
  static const Color patriarch = Color(0xFF6B0772);
  static const Color mediumVioletRed = Color(0xFFAF1281);
  static const Color royalFuchsia = Color(0xFFCF268A);
  static const Color raspberryPink = Color(0xFFE65C9C);
  static const Color flamingoPink = Color(0xFFFB8CAB);

  // static const Color deepViolet = Color(0xFFB13DDE);
  // static const Color patriarch = Color(0xFFDB5A60);
  // static const Color mediumVioletRed = Color(0xFFF375AE);
  // static const Color royalFuchsia = Color(0xFFE6A6D2);
  // static const Color raspberryPink = Color(0xFFFFB3D9);
  // static const Color flamingoPink = Color(0xFFFFCCEC);


  // Accent colors
  static const Color positive = Color(0xFF8AE234);
  static const Color warning = Color(0xFFFFC300);
  static const Color alert = Color(0xFFE91C4C);
  static const Color neutral = Color(0xFFF4E1FF);

  // Color aliases for compatibility
  static const Color positiveGreen = positive;
  static const Color warningYellow = warning;
  static const Color alertRed = alert;
  static const Color background = Color(0xFF1E1E1E);





  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF320B4C),
      Color(0xFF6B1D8C),
      Color(0xFFB13DDE),
    ],
  );

  static const LinearGradient trainerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF8B2D5D),
      Color(0xFFDB5A60),
      Color(0xFFF375AE),
    ],
  );

  static const LinearGradient ownerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF320B4C),
      Color(0xFFF375AE),
      Color(0xFFFFB3D9),
    ],
  );
}