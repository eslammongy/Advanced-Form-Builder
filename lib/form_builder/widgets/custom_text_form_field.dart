import 'package:flutter/material.dart';
import 'package:form_builder/theme/app_colors.dart';
import 'package:form_builder/utils/app_extensions.dart';
import 'package:form_builder/utils/sizer_util.dart';
import 'package:form_builder/form_builder/controllers/form_state.dart'
    as form_state;

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.onFieldSubmitted,
    this.label,
    required this.inputType,
    required this.formField,
    this.controller,
    this.hint,
    this.obscureText = false,
    this.readOnly = false,
    this.suffix,
    this.prefix,
    this.hintColor,
  });

  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool readOnly;
  final String? label;
  final String? hint;
  final bool obscureText;
  final Color? hintColor;
  final Widget? suffix;
  final Widget? prefix;
  final form_state.FormField formField;
  final TextInputType inputType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45.h,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        style: context.textTheme.bodyLarge?.copyWith(
          color: context.customColors.textPrimary,
        ),
        cursorColor: AppColors.primaryDark,
        autocorrect: true,
        enableSuggestions: true,
        obscureText: obscureText,
        obscuringCharacter: "*",
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: formField.error,
          suffixIcon: suffix,
          prefixIcon: prefix,
          focusedBorder: context.theme.inputDecorationTheme.focusedBorder
              ?.copyWith(
                borderSide: BorderSide(
                  color: formField.isValid ? Colors.blue : Colors.red,
                ),
              ),
        ),
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged != null ? (value) => onChanged!(value) : null,
        onFieldSubmitted: onFieldSubmitted != null
            ? (value) => onFieldSubmitted!(value)
            : null,
      ),
    );
  }
}
