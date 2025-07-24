enum FormType { signIn, signUp, guest, admin }

class FormField {
  const FormField({this.value = '', this.error, this.isValid = true});

  final String? error;
  final bool isValid;
  final String value;

  FormField copyWith({String? value, String? error, bool? isValid}) {
    return FormField(
      value: value ?? this.value,
      error: error,
      isValid: isValid ?? this.isValid,
    );
  }
}

class FormState {
  const FormState({
    this.userName = const FormField(),
    this.email = const FormField(),
    this.password = const FormField(),
    this.confirmPassword = const FormField(),
    this.phoneNumber = const FormField(),
    this.userId = const FormField(),
    this.rule = const FormField(),
    this.privacyPolicy = const FormField(),
    this.formType = FormType.signIn,
    this.isSubmitting = false,
    this.isFormValid = false,
  });

  final FormField confirmPassword;
  final FormField email;
  final FormType formType;
  final bool isFormValid;
  final bool isSubmitting;
  final FormField password;
  final FormField phoneNumber;
  final FormField privacyPolicy;
  final FormField rule;
  final FormField userId;
  final FormField userName;

  FormState copyWith({
    FormField? userName,
    FormField? email,
    FormField? password,
    FormField? confirmPassword,
    FormField? phoneNumber,
    FormField? userId,
    FormField? rule,
    FormField? privacyPolicy,
    FormType? formType,
    bool? isSubmitting,
    bool? isFormValid,
  }) {
    return FormState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      userId: userId ?? this.userId,
      rule: rule ?? this.rule,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      formType: formType ?? this.formType,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
