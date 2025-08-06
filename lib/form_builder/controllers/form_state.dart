enum FormType { signIn, signUp, guest, admin }

class MainFormField {
  final String value;
  final String? error;
  final bool isValid;

  const MainFormField({this.value = '', this.error, this.isValid = true});

  MainFormField copyWith({String? value, String? error, bool? isValid}) {
    return MainFormField(
      value: value ?? this.value,
      error: error,
      isValid: isValid ?? this.isValid,
    );
  }
}

// Individual form type states with scoped fields
class SignInFormState {
  final MainFormField password;
  final MainFormField email;
  final bool isSubmitting;
  final bool isFormValid;

  const SignInFormState({
    this.password = const MainFormField(),
    this.email = const MainFormField(),
    this.isSubmitting = false,
    this.isFormValid = false,
  });

  SignInFormState copyWith({
    MainFormField? password,
    MainFormField? email,
    bool? isSubmitting,
    bool? isFormValid,
  }) {
    return SignInFormState(
      password: password ?? this.password,
      email: email ?? this.email,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}

class SignUpFormState {
  final MainFormField userName;
  final MainFormField email;
  final MainFormField password;
  final MainFormField confirmPassword;
  final MainFormField phoneNumber;
  final MainFormField privacyPolicy;
  final bool isSubmitting;
  final bool isFormValid;

  const SignUpFormState({
    this.userName = const MainFormField(),
    this.email = const MainFormField(),
    this.password = const MainFormField(),
    this.confirmPassword = const MainFormField(),
    this.phoneNumber = const MainFormField(),
    this.privacyPolicy = const MainFormField(),
    this.isSubmitting = false,
    this.isFormValid = false,
  });

  SignUpFormState copyWith({
    MainFormField? userName,
    MainFormField? email,
    MainFormField? password,
    MainFormField? confirmPassword,
    MainFormField? phoneNumber,
    MainFormField? privacyPolicy,
    bool? isSubmitting,
    bool? isFormValid,
  }) {
    return SignUpFormState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      privacyPolicy: privacyPolicy ?? this.privacyPolicy,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}

class GuestFormState {
  final MainFormField userName;
  final bool isSubmitting;
  final bool isFormValid;

  const GuestFormState({
    this.userName = const MainFormField(),
    this.isSubmitting = false,
    this.isFormValid = false,
  });

  GuestFormState copyWith({
    MainFormField? userName,
    bool? isSubmitting,
    bool? isFormValid,
  }) {
    return GuestFormState(
      userName: userName ?? this.userName,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}

class AdminFormState {
  final MainFormField userName;
  final MainFormField userId;
  final MainFormField rule;
  final bool isSubmitting;
  final bool isFormValid;

  const AdminFormState({
    this.userName = const MainFormField(),
    this.userId = const MainFormField(),
    this.rule = const MainFormField(),
    this.isSubmitting = false,
    this.isFormValid = false,
  });

  AdminFormState copyWith({
    MainFormField? userName,
    MainFormField? userId,
    MainFormField? rule,
    bool? isSubmitting,
    bool? isFormValid,
  }) {
    return AdminFormState(
      userName: userName ?? this.userName,
      userId: userId ?? this.userId,
      rule: rule ?? this.rule,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}

// Main form state that manages current form type and navigation
class MainFormState {
  final FormType currentFormType;
  final SignInFormState signInForm;
  final SignUpFormState signUpForm;
  final GuestFormState guestForm;
  final AdminFormState adminForm;

  const MainFormState({
    this.currentFormType = FormType.signIn,
    this.signInForm = const SignInFormState(),
    this.signUpForm = const SignUpFormState(),
    this.guestForm = const GuestFormState(),
    this.adminForm = const AdminFormState(),
  });

  MainFormState copyWith({
    FormType? currentFormType,
    SignInFormState? signInForm,
    SignUpFormState? signUpForm,
    GuestFormState? guestForm,
    AdminFormState? adminForm,
  }) {
    return MainFormState(
      currentFormType: currentFormType ?? this.currentFormType,
      signInForm: signInForm ?? this.signInForm,
      signUpForm: signUpForm ?? this.signUpForm,
      guestForm: guestForm ?? this.guestForm,
      adminForm: adminForm ?? this.adminForm,
    );
  }
}
