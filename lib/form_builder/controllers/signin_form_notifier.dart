import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/utils/form_validators.dart';
import 'package:riverpod/riverpod.dart';

class SignInFormNotifier extends StateNotifier<SignInFormState> {
  SignInFormNotifier() : super(const SignInFormState());

  void updatePassword(String value) {
    final error = FormValidators.validatePassword(value);
    state = state.copyWith(
      password: MainFormField(
        value: value,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  void updateEmail(String value) {
    final error = FormValidators.validateEmail(value);
    state = state.copyWith(
      email: MainFormField(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void _validateForm() {
    final isValid =
        state.password.isValid &&
        state.password.value.isNotEmpty &&
        state.email.isValid &&
        state.email.value.isNotEmpty;
    state = state.copyWith(isFormValid: isValid);
  }

  Future<void> submitForm() async {
    if (!state.isFormValid) return;

    state = state.copyWith(isSubmitting: true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      reset();
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }

  void reset() {
    state = const SignInFormState();
  }

  void validateAllFields() {
    updatePassword(state.password.value);
    updateEmail(state.email.value);
  }
}
