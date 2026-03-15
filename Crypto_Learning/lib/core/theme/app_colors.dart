import 'package:flutter/material.dart';

class AppColors {
  // Brand - Soft Ocean Theme
  static const primary = Color(0xFF60A5FA); // Soft Blue
  static const background = Color(0xFF0F172A); // Slate Blue Dark
  static const surface = Color(0xFF1E293B); // Slate Blue Surface
  static const surfaceHighlight = Color(0xFF334155); // Hover state

  // States
  static const success = Color(0xFF34D399); // Soft Green
  static const danger = Color(0xFFF87171); // Soft Red
  static const warning = Color(0xFFFBBF24); // Soft Yellow

  // Text
  static const textPrimary = Color(0xFFF8FAFC);
  static const textSecondary = Color(0xFF94A3B8);

  // Light Theme
  static const lightBackground = Color(0xFFF8FAFC);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightTextPrimary = Color(0xFF0F172A);
  static const lightTextSecondary = Color(0xFF475569);
}

extension ThemeColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get bgColor =>
      isDark ? AppColors.background : AppColors.lightBackground;
  Color get cardColor => isDark ? AppColors.surface : AppColors.lightSurface;
  Color get textPrimary =>
      isDark ? AppColors.textPrimary : AppColors.lightTextPrimary;
  Color get textSecondary =>
      isDark ? AppColors.textSecondary : AppColors.lightTextSecondary;
  Color get borderColor =>
      isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
  Color get dividerColor =>
      isDark ? const Color(0xFF334155) : const Color(0xFFE2E8F0);
}
