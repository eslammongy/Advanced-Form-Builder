import 'package:flutter/material.dart';

/// Custom colors that don't fit in the standard Material color scheme
class CustomColors extends ThemeExtension<CustomColors> {
  final Color deepOrange;
  final Color priorityHigh;
  final Color priorityMedium;
  final Color priorityLow;
  final Color borderColor;
  final Color textPrimary;
  final Color textSecondary;

  const CustomColors({
    required this.deepOrange,
    required this.priorityHigh,
    required this.priorityMedium,
    required this.priorityLow,
    required this.borderColor,
    required this.textPrimary,
    required this.textSecondary,
  });

  @override
  ThemeExtension<CustomColors> copyWith({
    Color? deepOrange,
    Color? priorityHigh,
    Color? priorityMedium,
    Color? priorityLow,
    Color? borderColor,
    Color? textPrimary,
    Color? textSecondary,
  }) {
    return CustomColors(
      deepOrange: deepOrange ?? this.deepOrange,
      priorityHigh: priorityHigh ?? this.priorityHigh,
      priorityMedium: priorityMedium ?? this.priorityMedium,
      priorityLow: priorityLow ?? this.priorityLow,
      borderColor: borderColor ?? this.borderColor,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
    );
  }

  @override
  ThemeExtension<CustomColors> lerp(
    ThemeExtension<CustomColors>? other,
    double t,
  ) {
    if (other is! CustomColors) {
      return this;
    }
    return CustomColors(
      deepOrange: Color.lerp(deepOrange, other.deepOrange, t)!,
      priorityHigh: Color.lerp(priorityHigh, other.priorityHigh, t)!,
      priorityMedium: Color.lerp(priorityMedium, other.priorityMedium, t)!,
      priorityLow: Color.lerp(priorityLow, other.priorityLow, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
    );
  }
}

// App colors definitions
class AppColors {
  // Use a private constructor to prevent instantiation
  AppColors._();

  // Light Theme Colors
  static const Color primaryLight = Color(0xFF4A6FE3);
  static const Color secondaryLight = Color(0xFF32D4A4);
  static const Color backgroundLight = Color(0xFFF9FAFC);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color errorLight = Color(0xFFB00020);
  static const Color textPrimaryLight = Color(0xFF121212);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color borderColorLight = Color(0xFFE0E0E0);

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF4A6FE3);
  static const Color secondaryDark = Color(0xFF32D4A4);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1B1B1B);
  static const Color errorDark = Color(0xFFE53935);
  static const Color textPrimaryDark = Color(0xFFEEEEEE);
  static const Color textSecondaryDark = Color(0xFFB3B3B3);
  static const Color borderColorDark = Color(0xFF383838);

  // Common colors
  static const Color deepOrange = Color(0xFFFF6F00); // Deep Orange
  static const Color darkOrange = Color(0xFFE65100); // Burnt Orange
  static const Color priorityHigh = Color(0xFFF56565); // Soft Red
  static const Color priorityMedium = Color(0xFFECC94B); // Amber
  static const Color priorityLow = Color(0xFF63B3ED); // Light Blue
}
