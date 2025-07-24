import 'package:flutter/material.dart';
import 'package:form_builder/theme/app_colors.dart';

/// Extension methods for easier theme access
extension ThemeGetter on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;
}

/// Extension for accessing custom colors
extension CustomColorsGetter on BuildContext {
  CustomColors get customColors {
    return Theme.of(this).extension<CustomColors>()!;
  }
}
