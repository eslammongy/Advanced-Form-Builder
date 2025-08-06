import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/main_form_notifier.dart';
import 'package:form_builder/form_builder/widgets/custom_text_form_field.dart';
import 'package:form_builder/form_builder/widgets/primary_app_button.dart';
import 'package:form_builder/theme/app_strings.dart';
import 'package:form_builder/utils/sizer_util.dart';

class SignInForm extends ConsumerWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userEmail = ref.watch(
      signInFormProvider.select((value) => value.email),
    );
    final userPassword = ref.watch(
      signInFormProvider.select((value) => value.password),
    );
    final isValidForm = ref.watch(
      signInFormProvider.select((value) => value.isFormValid),
    );
    final formNotifier = ref.read(signInFormProvider.notifier);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizerUtil.gapH(8),
        CustomTextFormField(
          inputType: TextInputType.emailAddress,
          formField: userEmail,
          label: AppStrings.email,
          hint: AppStrings.email,
          prefix: Icon(Icons.email_rounded),
          onChanged: (value) => formNotifier.updateEmail(value),
        ),
        SizerUtil.gapH(12),
        CustomTextFormField(
          inputType: TextInputType.visiblePassword,
          formField: userPassword,
          obscureText: true,
          label: AppStrings.password,
          hint: AppStrings.password,
          prefix: Icon(Icons.lock_rounded),
          onChanged: (value) => formNotifier.updatePassword(value),
        ),
        SizerUtil.gapH(32),
        AppPrimaryButton(
          text: AppStrings.signIN,
          variant: ButtonVariant.primary,
          width: double.maxFinite,
          isEnabled: isValidForm,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          onPressed: () {},
        ),
      ],
    );
  }
}
