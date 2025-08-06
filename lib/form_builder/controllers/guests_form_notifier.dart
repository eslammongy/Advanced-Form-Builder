import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/utils/form_validators.dart';
import 'package:riverpod/riverpod.dart';

class GuestFormNotifier extends StateNotifier<GuestFormState> {
  GuestFormNotifier() : super(const GuestFormState());

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

  void _validateForm() {
    final isValid = state.userName.isValid && state.userName.value.isNotEmpty;
    state = state.copyWith(isFormValid: isValid);
  }

  Future<void> submitForm() async {
    if (!state.isFormValid) return;

    state = state.copyWith(isSubmitting: true);
    try {
      await Future.delayed(const Duration(seconds: 2));
      print('Guest form submitted: ${state.userName.value}');
      reset();
    } catch (e) {
      print('Guest form error: $e');
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }

  void reset() {
    state = const GuestFormState();
  }

  void validateAllFields() {
    updateUserName(state.userName.value);
  }
}
