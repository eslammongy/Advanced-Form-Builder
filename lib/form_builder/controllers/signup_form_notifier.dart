import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/utils/form_validators.dart';

class SignUpFormNotifier extends StateNotifier<SignUpFormState> {
  SignUpFormNotifier() : super(const SignUpFormState());

  void updateUserName(String value) {
    final error = FormValidators.validateUserName(value);
    state = state.copyWith(
      userName: MainFormField(
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

  void updatePassword(String value) {
    final error = FormValidators.validatePassword(value);
    state = state.copyWith(
      password: MainFormField(
        value: value,
        error: error,
        isValid: error == null,
      ),
    );
    // Re-validate confirm password
    if (state.confirmPassword.value.isNotEmpty) {
      updateConfirmPassword(state.confirmPassword.value);
    }
    _validateForm();
  }

  void updateConfirmPassword(String value) {
    final error = FormValidators.validateConfirmPassword(
      value,
      state.password.value,
    );
    state = state.copyWith(
      confirmPassword: MainFormField(
        value: value,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  void updatePhoneNumber(String value) {
    final error = FormValidators.validatePhoneNumber(value);
    state = state.copyWith(
      phoneNumber: MainFormField(
        value: value,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  void updatePrivacyPolicy(bool value) {
    final stringValue = value.toString();
    final error = FormValidators.validatePrivacyPolicy(stringValue);
    state = state.copyWith(
      privacyPolicy: MainFormField(
        value: stringValue,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  void _validateForm() {
    final isValid =
        state.userName.isValid &&
        state.userName.value.isNotEmpty &&
        state.email.isValid &&
        state.email.value.isNotEmpty &&
        state.password.isValid &&
        state.password.value.isNotEmpty &&
        state.confirmPassword.isValid &&
        state.confirmPassword.value.isNotEmpty &&
        state.phoneNumber.isValid &&
        state.phoneNumber.value.isNotEmpty &&
        state.privacyPolicy.isValid &&
        state.privacyPolicy.value == 'true';
    state = state.copyWith(isFormValid: isValid);
  }

  Future<void> submitForm() async {
    if (!state.isFormValid) return;

    state = state.copyWith(isSubmitting: true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      print(
        'SignUp form submitted: ${state.userName.value}, ${state.email.value}',
      );
      reset();
    } catch (e) {
      print('SignUp form error: $e');
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }

  void reset() {
    state = const SignUpFormState();
  }

  void validateAllFields() {
    updateUserName(state.userName.value);
    updateEmail(state.email.value);
    updatePassword(state.password.value);
    updateConfirmPassword(state.confirmPassword.value);
    updatePhoneNumber(state.phoneNumber.value);
    updatePrivacyPolicy(state.privacyPolicy.value == 'true');
  }
}
