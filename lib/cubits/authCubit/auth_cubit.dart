import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/failed_request_model.dart';
import 'package:safsofa/models/register_success_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

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

  String MobToken;

  Future<void> getDataInBackground(RemoteMessage message) async {
    print("${message.data.toString()}");
    showToast(text: "${message.data.toString()}", color: Colors.green);
  }

  Future<String> getDeviceToken() async {
    String token;
    var messaging = FirebaseMessaging.instance;
    token = await messaging.getToken();
    print("token most:${token}");
    MobToken = token;
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print("${event.data.toString()}");
      showToast(text: "${event.data.toString()}", color: Colors.green);
    });
    FirebaseMessaging.onMessage.listen((event) {
      print("${event.data.toString()}");
      showToast(text: "${event.data.toString()}", color: Colors.green);
    });

    FirebaseMessaging.onBackgroundMessage(getDataInBackground);
    return token;
  }

  FailedResponseModel signupFailedResponse;
  RegisterSuccessModel signupSuccessResponse;

  void signUp({
    String lang,
    String name,
    String phone,
    String password,
    String email,
    String address,
  }) {
    emit(SignupLoadingState());

    Mhelper.postData(url: '/api/register', data: {
      "lang": "$lang",
      "firebase_id": "$MobToken",
      "name": "$name",
      "email": "$email}",
      "password": "$password",
      "phone": "$phone",
      "address": "$address",
    }).then((value) {
      print(value.data);
      if (value.data['status'] == true) {
        signupSuccessResponse = RegisterSuccessModel.fromJson(value.data);
        CacheHelper.setData(
            key: 'userInfo',
            value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
        emit(SignupSuccessState());
      }
      if (value.data['status'] == false) {
        signupFailedResponse = FailedResponseModel.fromJson(value.data);
        emit(SignupErrorState(value.data['message']));
      }
    }).catchError((error) {
      print(error);
    });
  }

  FailedResponseModel loginFailedResponse;
  RegisterSuccessModel loginSuccessResponse;

  void login({String phone, String password, String language}) {
    emit(LoginLoadingState());
    Mhelper.postData(url: authLogin, data: {
      "phone": phone,
      "lang": language,
      "firebase_id": MobToken,
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
