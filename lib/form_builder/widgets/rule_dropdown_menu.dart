import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/main_form_notifier.dart';
import 'package:form_builder/theme/app_colors.dart';
import 'package:form_builder/utils/app_extensions.dart';

class RulesDropdownMenu extends StatelessWidget {
  const RulesDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final adminFormNotifier = ref.read(adminFormProvider.notifier);
        final adminFormState = ref.watch(adminFormProvider);
        final rule = adminFormState.rule;
        return DropdownButtonFormField2<SystemRole>(
          isExpanded: true,
          decoration: InputDecoration(
            enabledBorder: rule.isValid
                ? context.theme.inputDecorationTheme.enabledBorder
                : context.theme.inputDecorationTheme.enabledBorder?.copyWith(
                    borderSide: BorderSide(color: context.colorScheme.error),
                  ),
          ),
          hint: Text(
            'Select Your Rule',
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: rule.isValid
                  ? context.customColors.textPrimary
                  : AppColors.errorDark,
            ),
          ),

          items: SystemRole.values
              .map(
                (item) => DropdownMenuItem<SystemRole>(
                  value: item,
                  child: Text(
                    item.name.capitalize,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            adminFormNotifier.updateRule(value?.name);
          },
          onMenuStateChange: (isOpen) {
            if (!isOpen && rule.value.isEmpty) {
              adminFormNotifier.updateRule(null);
            }
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.arrow_drop_down,
              color: rule.isValid ? AppColors.primaryDark : AppColors.errorDark,
            ),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            elevation: 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),

              color: context.customColors.borderColor,
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      },
    );
  }
}

enum SystemRole {
  projectManager,
  systemAdmin,
  superAdmin,
  databaseAdmin,
  serverAdmin,
}

extension StringExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}
