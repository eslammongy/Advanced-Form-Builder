import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/main_form_notifier.dart';
import 'package:form_builder/form_builder/widgets/custom_text_form_field.dart';
import 'package:form_builder/form_builder/widgets/password_field_controller.dart';
import 'package:form_builder/form_builder/widgets/primary_app_button.dart';
import 'package:form_builder/theme/app_strings.dart';
import 'package:form_builder/utils/sizer_util.dart';

class SignUpForm extends ConsumerWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(signUpFormProvider);
    final formNotifier = ref.read(signUpFormProvider.notifier);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizerUtil.gapH(8),
        CustomTextFormField(
          inputType: TextInputType.name,
          formField: formState.userName,
          label: AppStrings.userName,
          hint: AppStrings.userName,
          prefix: Icon(Icons.person_rounded),
          onChanged: (value) => formNotifier.updateUserName(value),
        ),
        SizerUtil.gapH(12),
        CustomTextFormField(
          inputType: TextInputType.emailAddress,
          formField: formState.email,
          label: AppStrings.email,
          hint: AppStrings.email,
          prefix: Icon(Icons.email_rounded),
          onChanged: (value) => formNotifier.updateEmail(value),
        ),
        SizerUtil.gapH(12),
        CustomTextFormField(
          inputType: TextInputType.phone,
          formField: formState.phoneNumber,
          label: AppStrings.phoneNumber,
          hint: AppStrings.phoneNumber,
          prefix: Icon(Icons.phone_enabled_rounded),
          onChanged: (value) => formNotifier.updatePhoneNumber(value),
        ),
        SizerUtil.gapH(12),
        PasswordFieldController(
          formField: formState.password,
          onChanged: (value) => formNotifier.updatePassword(value),
        ),
        SizerUtil.gapH(12),
        PasswordFieldController(
          formField: formState.confirmPassword,
          label: AppStrings.confirmPassword,
          hint: AppStrings.confirmPassword,
          onChanged: (value) => formNotifier.updateConfirmPassword(value),
        ),
        SizerUtil.gapH(32),
        AppPrimaryButton(
          text: AppStrings.signUp,
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
