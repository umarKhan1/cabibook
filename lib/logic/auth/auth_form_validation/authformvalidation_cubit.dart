import 'package:cabibook/logic/auth/auth_form_validation/authformvalidation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AuthValidationCubit extends Cubit<AuthFormState> {
  AuthValidationCubit() : super(AuthFormState());

  void onEmailChanged(String email) {
    final trimmedEmail = email.trim();
    final isValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(trimmedEmail);

    emit(state.copyWith(
      email: trimmedEmail,
      isEmailTouched: trimmedEmail.isNotEmpty,
      isEmailValid: trimmedEmail.isNotEmpty && isValid,
    ));
  }
// ignore: avoid_positional_boolean_parameters
void setSignIn(bool value) {
  emit(state.copyWith(isSignIn: value));
}
void onPhoneChanged(String phone, String code, bool isSignIn) {
  final trimmedPhone = phone.trim();
  final isTouched = trimmedPhone.isNotEmpty;

  emit(state.copyWith(
    phone: trimmedPhone,
    countryCode: code,
    isPhoneTouched: isTouched,
    isPhoneValid: isTouched && trimmedPhone.length >= 7,
    isSignIn: isSignIn, // Make sure this is passed properly
  ));
}



  bool get isFormValid {
    if (state.isSignIn) {
      return state.isPhoneTouched && state.isPhoneValid;
    } else {
      return state.isEmailTouched &&
             state.isPhoneTouched &&
             state.isEmailValid &&
             state.isPhoneValid;
    }
  }
}
