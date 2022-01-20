import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  bool showPassword = true;
  IconData passwordIcon = Icons.visibility;

  void changePasswordVisibility() {
    showPassword = !showPassword;
    passwordIcon = showPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}
