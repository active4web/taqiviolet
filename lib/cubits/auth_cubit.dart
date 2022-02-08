import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/failed_request_model.dart';
import 'package:safsofa/models/register_success_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_helper.dart';

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

  Future<String> getDeviceToken() async {
    String token;
    var messaging = FirebaseMessaging.instance;
    token = await messaging.getToken();
    print(token);
    return token;
  }

  FailedResponseModel signupFailedResponse;
  RegisterSuccessModel signupSuccessResponse;
  void signUp(
      {String fullName,
      String address,
      String phone,
      String password,
      String email,
      String language}) {
    emit(SignupLoadingState());
    DioHelper.postData(url: 'user_api/set_registration', data: {
      "key": 1234567890,
      "fullname": fullName,
      "phone": phone,
      "address": address,
      "lang": language,
      "firebase_id": getDeviceToken(),
      "password": password,
      "email": email
    }).then((value) {
      print(value.data);
      if (value.data['status'] == true) {
        signupSuccessResponse = RegisterSuccessModel.fromJson(value.data);
        CacheHelper.setData(
            key: 'userInfo',
            value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
        emit(SignupSuccessState(signupSuccessResponse));
      }
      if (value.data['status'] == false) {
        signupFailedResponse = FailedResponseModel.fromJson(value.data);
        emit(SignupErrorState(value.data['message']));
      }
    }).catchError((error) {
      emit(SignupErrorState(error.toString()));
      print(error);
    });
  }

  FailedResponseModel loginFailedResponse;
  RegisterSuccessModel loginSuccessResponse;
  void login({String phone, String password, String language}) {
    emit(LoginLoadingState());
    DioHelper.postData(url: 'pages/set_login', data: {
      "key": 1234567890,
      "phone": phone,
      "lang": language,
      "firebase_id": getDeviceToken(),
      "password": password,
    }).then((value) {
      print(value.data);
      if (value.data['status'] == true) {
        loginSuccessResponse = RegisterSuccessModel.fromJson(value.data);
        CacheHelper.setData(
            key: 'userInfo',
            value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
        emit(LoginSuccessState(loginSuccessResponse));
      }
      if (value.data['status'] == false) {
        loginFailedResponse = FailedResponseModel.fromJson(value.data);
        emit(LoginErrorState(value.data['message']));
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      print(error);
    });
  }
}
