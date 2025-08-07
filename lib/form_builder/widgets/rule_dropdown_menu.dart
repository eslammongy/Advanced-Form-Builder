import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/main_form_notifier.dart';
import 'package:form_builder/theme/app_colors.dart';
import 'package:form_builder/utils/app_extensions.dart';

enum Rules { manger, admin, superAdmin, database, server }

//create a string extension to convert first letter to uppercase
extension StringExtension on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';
}

class RulesDropdownMenu extends StatelessWidget {
  const RulesDropdownMenu({super.key});

  @override
  Widget build(BuildContext context) {
    Rules? selectedValue;

    return Consumer(
      builder: (context, ref, child) {
        final adminFormNotifier = ref.read(adminFormProvider.notifier);
        return DropdownButtonFormField2<Rules>(
          isExpanded: true,
          decoration: buttonDecoration(),
          hint: Text(
            'Select Your Rule',
            style: context.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          items: Rules.values
              .map(
                (item) => DropdownMenuItem<Rules>(
                  value: item,
                  child: Text(
                    item.name.capitalize,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            selectedValue = value;
            adminFormNotifier.updateRule(selectedValue!.name);
          },
          buttonStyleData: const ButtonStyleData(
            padding: EdgeInsets.only(right: 8),
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_drop_down, color: AppColors.primaryDark),
            iconSize: 24,
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          ),
          menuItemStyleData: const MenuItemStyleData(
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        );
      },
    );
  }

  InputDecoration buttonDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 14),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
