import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/form_controller.dart';
import 'package:form_builder/form_builder/widgets/custom_text_form_field.dart';
import 'package:form_builder/form_builder/widgets/primary_app_button.dart';
import 'package:form_builder/theme/app_strings.dart';
import 'package:form_builder/utils/sizer_util.dart';

class GuestForm extends ConsumerWidget {
  const GuestForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formNotifierProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomTextFormField(
          inputType: TextInputType.name,
          formField: formState.userName,
          label: AppStrings.userName,
          hint: AppStrings.userName,
          prefix: Icon(Icons.person_2_rounded),
          onChanged: null,
        ),

        SizerUtil.gapH(32),
        AppPrimaryButton(
          text: AppStrings.signIN,
          variant: ButtonVariant.primary,
          width: double.maxFinite,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          onPressed: () {},
        ),
      ],
    );
  }
}
