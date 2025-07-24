import 'package:flutter/foundation.dart';
import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/utils/form_validators.dart';
import 'package:riverpod/riverpod.dart';

enum FormFields {
  userName,
  email,
  password,
  confirmPassword,
  phoneNumber,
  userId,
  rule,
  privacyPolicy,
}

class FormNotifier extends StateNotifier<FormState> {
  FormNotifier() : super(const FormState());

  void setFormType(FormType formType) {
    state = state.copyWith(formType: formType);
    _validateForm();
  }

  void updateUserName(String value) {
    final error = _shouldValidateField(FormFields.userName)
        ? FormValidators.validateUserName(value)
        : null;
    state = state.copyWith(
      userName: FormField(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updateEmail(String value) {
    final error = _shouldValidateField(FormFields.email)
        ? FormValidators.validateEmail(value)
        : null;
    state = state.copyWith(
      email: FormField(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updatePassword(String value) {
    final error = _shouldValidateField(FormFields.password)
        ? FormValidators.validatePassword(value)
        : null;
    state = state.copyWith(
      password: FormField(value: value, error: error, isValid: error == null),
    );
    // Re-validate confirm password if it has a value
    if (state.confirmPassword.value.isNotEmpty) {
      updateConfirmPassword(state.confirmPassword.value);
    }
    _validateForm();
  }

  void updateConfirmPassword(String value) {
    final error = _shouldValidateField(FormFields.confirmPassword)
        ? FormValidators.validateConfirmPassword(value, state.password.value)
        : null;
    state = state.copyWith(
      confirmPassword: FormField(
        value: value,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  void updatePhoneNumber(String value) {
    final error = _shouldValidateField(FormFields.phoneNumber)
        ? FormValidators.validatePhoneNumber(value)
        : null;
    state = state.copyWith(
      phoneNumber: FormField(
        value: value,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  void updateUserId(String value) {
    final error = _shouldValidateField(FormFields.userId)
        ? FormValidators.validateUserId(value)
        : null;
    state = state.copyWith(
      userId: FormField(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updateRule(String value) {
    final error = _shouldValidateField(FormFields.rule)
        ? FormValidators.validateRule(value)
        : null;
    state = state.copyWith(
      rule: FormField(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updatePrivacyPolicy(bool value) {
    final stringValue = value.toString();
    final error = _shouldValidateField(FormFields.privacyPolicy)
        ? FormValidators.validatePrivacyPolicy(stringValue)
        : null;
    state = state.copyWith(
      privacyPolicy: FormField(
        value: stringValue,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  bool _shouldValidateField(FormFields fieldName) {
    switch (state.formType) {
      case FormType.signIn:
        return [FormFields.email, FormFields.password].contains(fieldName);
      case FormType.signUp:
        return [
          FormFields.userName,
          FormFields.email,
          FormFields.phoneNumber,
          FormFields.password,
          FormFields.confirmPassword,
          FormFields.privacyPolicy,
        ].contains(fieldName);
      case FormType.guest:
        return [FormFields.userName].contains(fieldName);
      case FormType.admin:
        return [
          FormFields.userId,
          FormFields.userName,
          FormFields.rule,
        ].contains(fieldName);
    }
  }

  void _validateForm() {
    final requiredFields = _getRequiredFields();
    bool isValid = true;

    for (final field in requiredFields) {
      final formField = _getFormField(field);
      if (!formField.isValid || formField.value.isEmpty) {
        isValid = false;
        break;
      }
    }

    state = state.copyWith(isFormValid: isValid);
  }

  List<FormFields> _getRequiredFields() {
    switch (state.formType) {
      case FormType.signIn:
        return [FormFields.email, FormFields.password];
      case FormType.signUp:
        return [
          FormFields.userName,
          FormFields.email,
          FormFields.phoneNumber,
          FormFields.password,
          FormFields.confirmPassword,
          FormFields.privacyPolicy,
        ];
      case FormType.guest:
        return [FormFields.userName];
      case FormType.admin:
        return [FormFields.userId, FormFields.userName, FormFields.rule];
    }
  }

  FormField _getFormField(FormFields fieldName) {
    switch (fieldName) {
      case FormFields.userName:
        return state.userName;
      case FormFields.email:
        return state.email;
      case FormFields.password:
        return state.password;
      case FormFields.confirmPassword:
        return state.confirmPassword;
      case FormFields.phoneNumber:
        return state.phoneNumber;
      case FormFields.userId:
        return state.userId;
      case FormFields.rule:
        return state.rule;
      case FormFields.privacyPolicy:
        return state.privacyPolicy;
    }
  }

  Future<void> submitForm() async {
    if (!state.isFormValid) return;

    state = state.copyWith(isSubmitting: true);

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      // Handle successful submission
      debugPrint('Form submitted successfully for ${state.formType.name}');
      // Reset form or navigate as needed
      _resetForm();
    } catch (e) {
      // Handle error
      debugPrint('Error submitting form: $e');
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }

  void _resetForm() {
    state = FormState(formType: state.formType);
  }

  void validateAllFields() {
    final requiredFields = _getRequiredFields();

    for (final field in requiredFields) {
      final currentField = _getFormField(field);
      final error = _getValidationError(field, currentField.value);

      if (error != null) {
        _updateFieldWithError(field, currentField.value, error);
      }
    }

    _validateForm();
  }

  String? _getValidationError(FormFields fieldName, String value) {
    switch (fieldName) {
      case FormFields.userName:
        return FormValidators.validateUserName(value);
      case FormFields.email:
        return FormValidators.validateEmail(value);
      case FormFields.password:
        return FormValidators.validatePassword(value);
      case FormFields.confirmPassword:
        return FormValidators.validateConfirmPassword(
          value,
          state.password.value,
        );
      case FormFields.phoneNumber:
        return FormValidators.validatePhoneNumber(value);
      case FormFields.userId:
        return FormValidators.validateUserId(value);
      case FormFields.rule:
        return FormValidators.validateRule(value);
      case FormFields.privacyPolicy:
        return FormValidators.validatePrivacyPolicy(value);
    }
  }

  void _updateFieldWithError(FormFields fieldName, String value, String error) {
    final field = FormField(value: value, error: error, isValid: false);

    switch (fieldName) {
      case FormFields.userName:
        state = state.copyWith(userName: field);
        break;
      case FormFields.email:
        state = state.copyWith(email: field);
        break;
      case FormFields.password:
        state = state.copyWith(password: field);
        break;
      case FormFields.confirmPassword:
        state = state.copyWith(confirmPassword: field);
        break;
      case FormFields.phoneNumber:
        state = state.copyWith(phoneNumber: field);
        break;
      case FormFields.userId:
        state = state.copyWith(userId: field);
        break;
      case FormFields.rule:
        state = state.copyWith(rule: field);
        break;
      case FormFields.privacyPolicy:
        state = state.copyWith(privacyPolicy: field);
        break;
    }
  }
}

final formProvider = StateNotifierProvider<FormNotifier, FormState>((ref) {
  return FormNotifier();
});
