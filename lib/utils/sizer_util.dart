import 'package:flutter/material.dart';

class SizerUtil {
  SizerUtil._();
  // // create a single instance of this class
  // static final SizerUtil _instance = SizerUtil._();
  // factory SizerUtil() => _instance;
  static const double designWidth = 375;
  static const double designHeight = 812;

  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _pixelRatio;
  static late double _textScalerValue;
  static const double p4 = 4.0;
  static const double p6 = 6.0;
  static const double p8 = 8.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p16 = 16.0;
  static const double p24 = 24.0;
  static const double p32 = 32.0;
  static const double p48 = 48.0;
  static const double p64 = 64.0;
  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _pixelRatio = _mediaQueryData.devicePixelRatio;
    _textScalerValue = _mediaQueryData.textScaler.scale(1.0);
  }

  static double get screenWidth => _screenWidth;
  static double get screenHeight => _screenHeight;
  static double get pixelRatio => _pixelRatio;
  static double get textScalerValue => _textScalerValue;

  /// Calculates a responsive width based on the design width.
  /// Use for widths of widgets, horizontal padding/margin.
  static double setWidth(double width) {
    return (width / designWidth) * _screenWidth;
  }

  /// Calculates a responsive height based on the design height.
  /// Use for heights of widgets, vertical padding/margin.
  /// Often better to scale height based on width to maintain aspect ratio consistency.
  static double setHeight(double height) {
    return (height / designWidth) * _screenWidth;
  }

  /// Calculates a responsive font size.
  /// This considers both screen width and the effective text scale factor.
  static double setSp(double fontSize) {
    // Scale font size based on screen width, then adjust for user's text scale factor
    return setWidth(fontSize) / _textScalerValue;
  }

  /// Calculates a responsive radius for BorderRadius or similar properties.
  static double setRadius(double radius) {
    return setWidth(radius);
  }

  /// Creates a horizontal SizedBox for responsive spacing.
  static Widget gapW(double width) {
    return SizedBox(width: setWidth(width));
  }

  /// Creates a vertical SizedBox for responsive spacing.
  static Widget gapH(double height) {
    return SizedBox(height: setHeight(height));
  }

  static EdgeInsetsGeometry setSpace({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: setWidth(left),
      top: setHeight(top),
      right: setWidth(right),
      bottom: setHeight(bottom),
    );
  }

  static EdgeInsetsGeometry setSymmetricSpace({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: setWidth(horizontal),
      vertical: setHeight(vertical),
    );
  }

  static EdgeInsetsGeometry setAllSpace(double padding) {
    return setSymmetricSpace(horizontal: padding, vertical: padding);
  }

  static double setWidthPercentage(double percentage) {
    return _screenWidth * (percentage / 100);
  }

  static double setHeightPercentage(double percentage) {
    return _screenHeight * (percentage / 100);
  }
}

extension SizeExtension on num {
  double get w => SizerUtil.setWidth(toDouble());
  double get h => SizerUtil.setHeight(toDouble());
  double get sp => SizerUtil.setSp(toDouble());
  double get r => SizerUtil.setRadius(toDouble());
  double get wp => SizerUtil.setWidthPercentage(toDouble());
  double get hp => SizerUtil.setHeightPercentage(toDouble());
}
