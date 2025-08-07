import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/main_form_notifier.dart';
import 'package:form_builder/form_builder/widgets/custom_text_form_field.dart';
import 'package:form_builder/form_builder/widgets/primary_app_button.dart';
import 'package:form_builder/form_builder/widgets/rule_dropdown_menu.dart';
import 'package:form_builder/theme/app_strings.dart';
import 'package:form_builder/utils/sizer_util.dart';

const items = [
  DropdownMenuItem(value: "Item 1", child: Text("Item 1")),
  DropdownMenuItem(value: "Item 2", child: Text("Item 2")),
  DropdownMenuItem(value: "Item 3", child: Text("Item 3")),
];

class AdminForm extends ConsumerWidget {
  const AdminForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(adminFormProvider);
    final formNotifier = ref.read(adminFormProvider.notifier);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizerUtil.gapH(8),
        CustomTextFormField(
          inputType: TextInputType.text,
          formField: formState.userId,
          label: AppStrings.userId,
          hint: AppStrings.userId,
          prefix: Icon(Icons.verified_user_rounded),
          onChanged: (value) => formNotifier.updateUserId(value),
        ),
        SizerUtil.gapH(12),
        CustomTextFormField(
          inputType: TextInputType.name,
          formField: formState.userName,
          label: AppStrings.userName,
          hint: AppStrings.userName,
          prefix: Icon(Icons.person_2_rounded),
          onChanged: (value) => formNotifier.updateUserName(value),
        ),
        SizerUtil.gapH(12),
        RulesDropdownMenu(),
        SizerUtil.gapH(32),
        AppPrimaryButton(
          text: AppStrings.signIN,
          variant: ButtonVariant.primary,
          width: double.maxFinite,
          isEnabled: formState.isFormValid,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          onPressed: () {},
        ),
      ],
    );
  }
}
