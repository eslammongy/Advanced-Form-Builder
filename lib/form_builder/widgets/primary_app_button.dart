import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_builder/utils/app_extensions.dart';
import 'package:form_builder/utils/sizer_util.dart';

enum ButtonVariant { primary, secondary, outline, text }

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final bool isLoading;
  final bool isEnabled;
  final EdgeInsets margin;
  final MainAxisAlignment mainAlignment;
  final Color? txtColor;
  final Color? brColor;
  final EdgeInsets padding;
  final double fontSize;
  final double iconSize;
  final double height;
  final double width;
  const AppPrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 42,
    this.width = double.infinity,
    this.variant = ButtonVariant.primary,
    this.fontSize = 16,
    this.iconSize = 20,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.isEnabled = false,
    this.mainAlignment = MainAxisAlignment.center,
    this.margin = const EdgeInsets.all(0),
    this.txtColor,
    this.brColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;
    Color borderColor = brColor ?? context.customColors.borderColor;

    switch (variant) {
      case ButtonVariant.primary:
        bgColor = context.colorScheme.primary;
        textColor = context.customColors.textPrimary;
        borderColor = Colors.transparent;
        break;
      case ButtonVariant.secondary:
        bgColor = context.colorScheme.surface;
        textColor = context.customColors.textPrimary;
        break;
      case ButtonVariant.outline:
        bgColor = context.colorScheme.surface;
        textColor = context.customColors.textPrimary;
        break;
      case ButtonVariant.text:
        bgColor = Colors.transparent;
        textColor = context.customColors.textPrimary;
        borderColor = Colors.transparent;
        break;
    }

    if (!isEnabled) {
      bgColor = bgColor.withValues(alpha: 0.5);
      textColor = textColor.withValues(alpha: 0.5);
    }

    return Padding(
      padding: margin,
      child: ElevatedButton(
        onPressed: !isEnabled
            ? null
            : () {
                HapticFeedback.mediumImpact();
                onPressed();
              },
        style: _buildStyle(bgColor, textColor, borderColor),
        child: _buildButtonBody(),
      ),
    );
  }

  Widget _buildButtonBody() {
    if (isLoading) {
      return _buildLoadingProgress(txtColor ?? Colors.white);
    }
    if (leadingIcon != null || trailingIcon != null) {
      return Row(
        mainAxisAlignment: mainAlignment,
        children: [
          if (leadingIcon != null) Icon(leadingIcon, size: iconSize),
          _buildButtonTitle(),
          if (trailingIcon != null) Icon(trailingIcon, size: iconSize),
        ],
      );
    }
    return _buildButtonTitle();
  }

  Text _buildButtonTitle() {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
        color: txtColor ?? Colors.white,
      ),
    );
  }

  ButtonStyle _buildStyle(Color bgColor, Color textColor, Color borderColor) {
    return ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: txtColor ?? textColor,
      elevation: variant == ButtonVariant.text ? 0 : 1,
      padding: padding,
      fixedSize: Size(width, height.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
        side: BorderSide(color: borderColor, width: 1.0),
      ),
    );
  }

  SizedBox _buildLoadingProgress(Color textColor) {
    return SizedBox(
      width: iconSize,
      height: iconSize,
      child: CircularProgressIndicator(
        strokeWidth: 2.0,
        valueColor: AlwaysStoppedAnimation<Color>(textColor),
      ),
    );
  }
}
