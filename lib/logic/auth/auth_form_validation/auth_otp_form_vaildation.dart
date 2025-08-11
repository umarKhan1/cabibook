import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit for managing OTP input state validation

class OTPCubit extends Cubit<String> {
  OTPCubit() : super('');
  void updateOTP(String otp) {
    emit(otp);
  }
  bool get isOTPComplete => state.length == 4;
}
