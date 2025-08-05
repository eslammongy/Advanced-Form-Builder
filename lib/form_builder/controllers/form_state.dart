enum FormType { signIn, signUp, guest, admin }

class FieldType {
  const FieldType({this.value = '', this.error, this.isValid = true});

  final String? error;
  final bool isValid;
  final String value;

  FieldType copyWith({String? value, String? error, bool? isValid}) {
    return FieldType(
      value: value ?? this.value,
      error: error,
      isValid: isValid ?? this.isValid,
    );
  }
}

class FormState {
  const FormState({
    this.userName = const FieldType(),
    this.email = const FieldType(),
    this.password = const FieldType(),
    this.confirmPassword = const FieldType(),
    this.phoneNumber = const FieldType(),
    this.userId = const FieldType(),
    this.rule = const FieldType(),
    this.privacyPolicy = const FieldType(),
    this.formType = FormType.signIn,
    this.isSubmitting = false,
    this.isFormValid = false,
  });

  final FieldType confirmPassword;
  final FieldType email;
  final FormType formType;
  final bool isFormValid;
  final bool isSubmitting;
  final FieldType password;
  final FieldType phoneNumber;
  final FieldType privacyPolicy;
  final FieldType rule;
  final FieldType userId;
  final FieldType userName;

  FormState copyWith({
    FieldType? userName,
    FieldType? email,
    FieldType? password,
    FieldType? confirmPassword,
    FieldType? phoneNumber,
    FieldType? userId,
    FieldType? rule,
    FieldType? privacyPolicy,
    FormType? formType,
    bool? isSubmitting,
    bool? isFormValid,
  }) {
    return FormState(
      userName: userName ?? this.userName,
      email: email ?? const FieldType(),
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
