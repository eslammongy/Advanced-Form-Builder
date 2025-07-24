import 'package:flutter/foundation.dart';
import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/utils/form_validators.dart';
import 'package:riverpod/riverpod.dart';

enum FieldTypes {
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
    final error = _shouldValidateField(FieldTypes.userName)
        ? FormValidators.validateUserName(value)
        : null;
    state = state.copyWith(
      userName: FieldType(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updateEmail(String value) {
    final error = _shouldValidateField(FieldTypes.email)
        ? FormValidators.validateEmail(value)
        : null;
    state = state.copyWith(
      email: FieldType(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updatePassword(String value) {
    final error = _shouldValidateField(FieldTypes.password)
        ? FormValidators.validatePassword(value)
        : null;
    state = state.copyWith(
      password: FieldType(value: value, error: error, isValid: error == null),
    );
    // Re-validate confirm password if it has a value
    if (state.confirmPassword.value.isNotEmpty) {
      updateConfirmPassword(state.confirmPassword.value);
    }
    _validateForm();
  }

  void updateConfirmPassword(String value) {
    final error = _shouldValidateField(FieldTypes.confirmPassword)
        ? FormValidators.validateConfirmPassword(value, state.password.value)
        : null;
    state = state.copyWith(
      confirmPassword: FieldType(
        value: value,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  void updatePhoneNumber(String value) {
    final error = _shouldValidateField(FieldTypes.phoneNumber)
        ? FormValidators.validatePhoneNumber(value)
        : null;
    state = state.copyWith(
      phoneNumber: FieldType(
        value: value,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  void updateUserId(String value) {
    final error = _shouldValidateField(FieldTypes.userId)
        ? FormValidators.validateUserId(value)
        : null;
    state = state.copyWith(
      userId: FieldType(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updateRule(String value) {
    final error = _shouldValidateField(FieldTypes.rule)
        ? FormValidators.validateRule(value)
        : null;
    state = state.copyWith(
      rule: FieldType(value: value, error: error, isValid: error == null),
    );
    _validateForm();
  }

  void updatePrivacyPolicy(bool value) {
    final stringValue = value.toString();
    final error = _shouldValidateField(FieldTypes.privacyPolicy)
        ? FormValidators.validatePrivacyPolicy(stringValue)
        : null;
    state = state.copyWith(
      privacyPolicy: FieldType(
        value: stringValue,
        error: error,
        isValid: error == null,
      ),
    );
    _validateForm();
  }

  bool _shouldValidateField(FieldTypes fieldName) {
    switch (state.formType) {
      case FormType.signIn:
        return [FieldTypes.email, FieldTypes.password].contains(fieldName);
      case FormType.signUp:
        return [
          FieldTypes.userName,
          FieldTypes.email,
          FieldTypes.phoneNumber,
          FieldTypes.password,
          FieldTypes.confirmPassword,
          FieldTypes.privacyPolicy,
        ].contains(fieldName);
      case FormType.guest:
        return [FieldTypes.userName].contains(fieldName);
      case FormType.admin:
        return [
          FieldTypes.userId,
          FieldTypes.userName,
          FieldTypes.rule,
        ].contains(fieldName);
    }
  }

  void _validateForm() {
    final requiredFields = _getRequiredFields();
    bool isValid = true;

    for (final field in requiredFields) {
      final FieldType = _getFieldType(field);
      if (!FieldType.isValid || FieldType.value.isEmpty) {
        isValid = false;
        break;
      }
    }

    state = state.copyWith(isFormValid: isValid);
  }

  List<FieldTypes> _getRequiredFields() {
    switch (state.formType) {
      case FormType.signIn:
        return [FieldTypes.email, FieldTypes.password];
      case FormType.signUp:
        return [
          FieldTypes.userName,
          FieldTypes.email,
          FieldTypes.phoneNumber,
          FieldTypes.password,
          FieldTypes.confirmPassword,
          FieldTypes.privacyPolicy,
        ];
      case FormType.guest:
        return [FieldTypes.userName];
      case FormType.admin:
        return [FieldTypes.userId, FieldTypes.userName, FieldTypes.rule];
    }
  }

  FieldType _getFieldType(FieldTypes fieldName) {
    switch (fieldName) {
      case FieldTypes.userName:
        return state.userName;
      case FieldTypes.email:
        return state.email;
      case FieldTypes.password:
        return state.password;
      case FieldTypes.confirmPassword:
        return state.confirmPassword;
      case FieldTypes.phoneNumber:
        return state.phoneNumber;
      case FieldTypes.userId:
        return state.userId;
      case FieldTypes.rule:
        return state.rule;
      case FieldTypes.privacyPolicy:
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
      final currentField = _getFieldType(field);
      final error = _getValidationError(field, currentField.value);

      if (error != null) {
        _updateFieldWithError(field, currentField.value, error);
      }
    }

    _validateForm();
  }

  String? _getValidationError(FieldTypes fieldName, String value) {
    switch (fieldName) {
      case FieldTypes.userName:
        return FormValidators.validateUserName(value);
      case FieldTypes.email:
        return FormValidators.validateEmail(value);
      case FieldTypes.password:
        return FormValidators.validatePassword(value);
      case FieldTypes.confirmPassword:
        return FormValidators.validateConfirmPassword(
          value,
          state.password.value,
        );
      case FieldTypes.phoneNumber:
        return FormValidators.validatePhoneNumber(value);
      case FieldTypes.userId:
        return FormValidators.validateUserId(value);
      case FieldTypes.rule:
        return FormValidators.validateRule(value);
      case FieldTypes.privacyPolicy:
        return FormValidators.validatePrivacyPolicy(value);
    }
  }

  void _updateFieldWithError(FieldTypes fieldName, String value, String error) {
    final field = FieldType(value: value, error: error, isValid: false);

    switch (fieldName) {
      case FieldTypes.userName:
        state = state.copyWith(userName: field);
        break;
      case FieldTypes.email:
        state = state.copyWith(email: field);
        break;
      case FieldTypes.password:
        state = state.copyWith(password: field);
        break;
      case FieldTypes.confirmPassword:
        state = state.copyWith(confirmPassword: field);
        break;
      case FieldTypes.phoneNumber:
        state = state.copyWith(phoneNumber: field);
        break;
      case FieldTypes.userId:
        state = state.copyWith(userId: field);
        break;
      case FieldTypes.rule:
        state = state.copyWith(rule: field);
        break;
      case FieldTypes.privacyPolicy:
        state = state.copyWith(privacyPolicy: field);
        break;
    }
  }
}

final formProvider = StateNotifierProvider<FormNotifier, FormState>((ref) {
  return FormNotifier();
});
