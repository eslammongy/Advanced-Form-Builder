import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/utils/form_validators.dart';

class AdminFormNotifier extends StateNotifier<AdminFormState> {
  AdminFormNotifier() : super(const AdminFormState());

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

  void updateUserId(String value) {
    final error = FormValidators.validateUserId(value);
    state = state.copyWith(
      userId: MainFormField(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updateRule(String? value) {
    final error = FormValidators.validateRule(value);
    state = state.copyWith(
      rule: MainFormField(
        value: value ?? "",
        error: error,
        isValid: error == null,
      ),
    );
    debugPrint("Is valid: ${state.rule.isValid}");
    _validateForm();
  }

  void _validateForm() {
    final isValid =
        state.userName.isValid &&
        state.userName.value.isNotEmpty &&
        state.userId.isValid &&
        state.userId.value.isNotEmpty &&
        state.rule.isValid &&
        state.rule.value.isNotEmpty;
    state = state.copyWith(isFormValid: isValid);
  }

  Future<void> submitForm() async {
    if (!state.isFormValid) return;

    state = state.copyWith(isSubmitting: true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      print(
        'Admin form submitted: ${state.userName.value}, ${state.userId.value}',
      );
      reset();
    } catch (e) {
      print('Admin form error: $e');
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }

  void reset() {
    state = const AdminFormState();
  }

  void validateAllFields() {
    updateUserName(state.userName.value);
    updateUserId(state.userId.value);
    updateRule(state.rule.value);
  }
}
