import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthCubitTabEnum { signIn, signUp }

class AuthTabCubitTab extends Cubit<AuthCubitTabEnum> {
  AuthTabCubitTab() : super(AuthCubitTabEnum.signUp);

  void showSignIn() => emit(AuthCubitTabEnum.signIn);
  void showSignUp() => emit(AuthCubitTabEnum.signUp);
}
