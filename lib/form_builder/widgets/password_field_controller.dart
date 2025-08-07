import 'package:flutter/material.dart';
import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/form_builder/widgets/custom_text_form_field.dart';
import 'package:form_builder/theme/app_strings.dart';

class PasswordFieldController extends StatefulWidget {
  const PasswordFieldController({
    super.key,
    this.onChanged,
    required this.formField,
    this.label,
    this.hint,
  });
  final Function(String)? onChanged;
  final MainFormField formField;

  final String? label;
  final String? hint;
  @override
  State<PasswordFieldController> createState() =>
      _PasswordFieldControllerState();
}

class _PasswordFieldControllerState extends State<PasswordFieldController> {
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      inputType: TextInputType.visiblePassword,
      formField: widget.formField,
      obscureText: isVisible,
      label: widget.label ?? AppStrings.password,
      hint: widget.hint ?? AppStrings.password,
      prefix: Icon(Icons.lock_rounded),
      suffix: _buildPasswordSuffix(),
      onChanged: (value) {
        widget.onChanged!(value);
      },
    );
  }

  InkWell _buildPasswordSuffix() {
    return InkWell(
      onTap: () => setState(() => isVisible = !isVisible),
      child: isVisible
          ? const Icon(Icons.visibility_off_rounded)
          : const Icon(Icons.visibility_rounded),
    );
  }
}
