import 'package:form_builder/form_builder/controllers/admin_form_notifier.dart';
import 'package:form_builder/form_builder/controllers/form_state.dart';
import 'package:form_builder/form_builder/controllers/guests_form_notifier.dart';
import 'package:form_builder/form_builder/controllers/signin_form_notifier.dart';
import 'package:form_builder/form_builder/controllers/signup_form_notifier.dart';
import 'package:riverpod/riverpod.dart';


// Provider instances for each form type
final signInFormProvider =
    StateNotifierProvider<SignInFormNotifier, SignInFormState>((ref) {
      return SignInFormNotifier();
    });

final signUpFormProvider =
    StateNotifierProvider<SignUpFormNotifier, SignUpFormState>((ref) {
      return SignUpFormNotifier();
    });

final guestFormProvider =
    StateNotifierProvider<GuestFormNotifier, GuestFormState>((ref) {
      return GuestFormNotifier();
    });

final adminFormProvider =
    StateNotifierProvider<AdminFormNotifier, AdminFormState>((ref) {
      return AdminFormNotifier();
    });

