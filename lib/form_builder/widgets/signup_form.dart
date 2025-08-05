import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/form_controller.dart';
import 'package:form_builder/form_builder/widgets/custom_text_form_field.dart';
import 'package:form_builder/form_builder/widgets/primary_app_button.dart';
import 'package:form_builder/theme/app_strings.dart';
import 'package:form_builder/utils/sizer_util.dart';

class SignUpForm extends ConsumerWidget {
  const SignUpForm({super.key});

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
          prefix: Icon(Icons.person_rounded),
          onChanged: null,
        ),
        SizerUtil.gapH(12),
        CustomTextFormField(
          inputType: TextInputType.emailAddress,
          formField: formState.email,
          label: AppStrings.email,
          hint: AppStrings.email,
          prefix: Icon(Icons.email_rounded),
          onChanged: null,
        ),
        SizerUtil.gapH(12),
        CustomTextFormField(
          inputType: TextInputType.phone,
          formField: formState.phoneNumber,
          label: AppStrings.phoneNumber,
          hint: AppStrings.phoneNumber,
          prefix: Icon(Icons.phone_enabled_rounded),
          onChanged: null,
        ),
        SizerUtil.gapH(12),
        CustomTextFormField(
          inputType: TextInputType.visiblePassword,
          formField: formState.password,
          obscureText: true,
          label: AppStrings.password,
          hint: AppStrings.password,
          prefix: Icon(Icons.lock_rounded),
          onChanged: null,
        ),
        SizerUtil.gapH(12),
        CustomTextFormField(
          inputType: TextInputType.visiblePassword,
          formField: formState.confirmPassword,
          obscureText: true,
          label: AppStrings.confirmPassword,
          hint: AppStrings.confirmPassword,
          prefix: Icon(Icons.lock_rounded),
          onChanged: null,
        ),
        SizerUtil.gapH(32),
        AppPrimaryButton(
          text: AppStrings.signUp,
          variant: ButtonVariant.primary,
          width: double.maxFinite,
          isDisabled: formState.isFormValid == false,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          onPressed: () {},
        ),
      ],
    );
  }
}
