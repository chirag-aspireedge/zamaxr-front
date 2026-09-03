import 'package:flutter/material.dart';

class AppColor {
  AppColor._();

  // Primary & Splash Gradients (#56BAE4 0% -> #0D5D9A 100%)
  static const Color splashGradientTop = Color(0xFF56BAE4);
  static const Color splashGradientBottom = Color(0xFF0D5D9A);

  static const LinearGradient splashGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      splashGradientTop,
      splashGradientBottom,
    ],
    stops: [0.0, 1.0],
  );

  // Button Gradients (#56B9E3 0% -> #0E5E9B 100%)
  static const Color buttonGradientStart = Color(0xFF56B9E3);
  static const Color buttonGradientEnd = Color(0xFF0E5E9B);

  static const LinearGradient primaryButtonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      buttonGradientStart,
      buttonGradientEnd,
    ],
  );

  // Core Colors
  static const Color primary = Color(0xFF0D5D9A);
  static const Color secondary = Color(0xFF56BAE4);
  static const Color accent = Color(0xFFFF7A00);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textMuted = Color(0xFF94A3B8);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);
}
