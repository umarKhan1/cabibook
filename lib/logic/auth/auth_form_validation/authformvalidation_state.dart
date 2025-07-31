class AuthFormState {

  AuthFormState({
    this.email = '',
    this.phone = '',
    this.countryCode = '',
    this.isEmailValid = true,
    this.isPhoneValid = true,
    this.isEmailTouched = false,
    this.isPhoneTouched = false,
    this.isSignIn = false,
  });
  final String email;
  final String phone;
  final String countryCode;
  final bool isEmailValid;
  final bool isPhoneValid;
  final bool isEmailTouched;
  final bool isPhoneTouched;
  final bool isSignIn;

  AuthFormState copyWith({
    String? email,
    String? phone,
    String? countryCode,
    bool? isEmailValid,
    bool? isPhoneValid,
    bool? isEmailTouched,
    bool? isPhoneTouched,
    bool? isSignIn,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isEmailTouched: isEmailTouched ?? this.isEmailTouched,
      isPhoneTouched: isPhoneTouched ?? this.isPhoneTouched,
      isSignIn: isSignIn ?? this.isSignIn,
    );
  }
}
