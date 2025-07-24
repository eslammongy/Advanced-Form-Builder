import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/form_controller.dart';
import 'package:form_builder/form_builder/widgets/custom_text_form_field.dart';
import 'package:form_builder/form_builder/widgets/primary_app_button.dart';
import 'package:form_builder/theme/app_strings.dart';
import 'package:form_builder/utils/sizer_util.dart';

class SignInForm extends ConsumerWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formProvider);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
          inputType: TextInputType.visiblePassword,
          formField: formState.email,
          obscureText: true,
          label: AppStrings.password,
          hint: AppStrings.password,
          prefix: Icon(Icons.lock_rounded),
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
