import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/main_form_notifier.dart';
import 'package:form_builder/form_builder/widgets/custom_text_form_field.dart';
import 'package:form_builder/form_builder/widgets/password_field_controller.dart';
import 'package:form_builder/form_builder/widgets/primary_app_button.dart';
import 'package:form_builder/theme/app_strings.dart';
import 'package:form_builder/utils/sizer_util.dart';

class SignInForm extends ConsumerWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(signInFormProvider);
    final formNotifier = ref.read(signInFormProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizerUtil.gapH(8),
        CustomTextFormField(
          inputType: TextInputType.emailAddress,
          formField: formState.email,
          label: AppStrings.email,
          hint: AppStrings.email,
          prefix: Icon(Icons.email_rounded),
          onChanged: (value) => formNotifier.updateEmail(value),
        ),
        SizerUtil.gapH(12),
        PasswordFieldController(
          formField: formState.password,
          onChanged: (value) => formNotifier.updatePassword(value),
        ),
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
