import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/failed_request_model.dart';
import 'package:safsofa/models/register_success_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../push_notifcation.dart';
import '../../screens/home_layout.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);
  PushNotificationManagger _pushNotificationManagger =
      PushNotificationManagger();

  bool showPassword = true;
  IconData passwordIcon = Icons.visibility;

  void changePasswordVisibility() {
    showPassword = !showPassword;
    passwordIcon = showPassword
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }

  double strength = 0;
  String passStrengthHint = '';
  void changePasswordStrength(
      {@required double strengthVal, @required String passHint}) {
    strength = strengthVal;
    // passStrengthHint = passHint;
    emit(ChangePasswordVisibilityState());
  }

  String MobToken;

  Future<void> getDataInBackground(RemoteMessage message) async {
    log("${message.data.toString()}");
    showToast(text: "${message.data.toString()}", color: Colors.green);
  }

  Future<String> getDeviceToken() async {
    String token;
    var messaging = FirebaseMessaging.instance;
    token = await messaging.getToken();
    log("token most:${token}");
    MobToken = token;
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      log("${event.data.toString()}");
      showToast(text: "${event.data.toString()}", color: Colors.green);
    });
    FirebaseMessaging.onMessage.listen((event) {
      log("${event.data.toString()}");
      showToast(text: "${event.data.toString()}", color: Colors.green);
    });

    FirebaseMessaging.onBackgroundMessage(getDataInBackground);
    return token;
  }

  FailedResponseModel emailRegisterFailedResponse;
  RegisterSuccessModel emailRegisterSuccessResponse;
  FailedResponseModel phoneRegisterFailedResponse;
  RegisterSuccessModel phoneRegisterSuccessResponse;

  void registerWithEmail({
    String lang,
    String name,
    String password,
    String email,
    String address,
    //key=1 for phone register
    //key=2 for email register
    String key,
  }) {
    emit(EmailSignupLoadingState());

    Mhelper.postData(url: '/api/register', data: {
      "lang": "$lang",
      "firebase_id": "$MobToken",
      "name": "$name",
      "email": "$email",
      "password": "$password",
      "address": "$address",
      "key": key
    }).then((value) {
      log(value.data.toString());
      if (value.data['status'] == true) {
        emailRegisterSuccessResponse =
            RegisterSuccessModel.fromJson(value.data);
        CacheHelper.setData(
            key: 'userInfo',
            value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
        //     CacheHelper.setData(key: 'token', value: emailRegisterSuccessResponse.data.token);
        // kToken = CacheHelper.getData('token');
        // CacheHelper.setData(
        //     key: 'token', value: signupSuccessResponse.data.token);
        // kToken = CacheHelper.getData('token');
        emit(EmailSignupSuccessState(emailRegisterSuccessResponse));
      }
      if (value.data['status'] == false) {
        emailRegisterFailedResponse = FailedResponseModel.fromJson(value.data);
        emit(EmailSignupErrorState(value.data['msg']));
      }
    }).catchError((error) {
      log(error.toString());
    });
  }

  void registerWithPhone({
    String lang,
    String name,
    String phone,
    String password,
    String address,
    //key=1 for phone register
    //key=2 for email register
    String key,
  }) {
    emit(PhoneSignupLoadingState());

    Mhelper.postData(url: '/api/register', data: {
      "lang": "$lang",
      "firebase_id": "$MobToken",
      "name": "$name",
      "password": "$password",
      "phone": "$phone",
      "address": "$address",
      "key": key
    }).then((value) {
      log(value.data.toString());
      if (value.data['status'] == true) {
        phoneRegisterSuccessResponse =
            RegisterSuccessModel.fromJson(value.data);
        CacheHelper.setData(
            key: 'userInfo',
            value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
        //     CacheHelper.setData(key: 'token', value: phoneRegisterSuccessResponse.data.token);
        // kToken = CacheHelper.getData('token');
        // CacheHelper.setData(
        //     key: 'token', value: signupSuccessResponse.data.token);
        // kToken = CacheHelper.getData('token');
        emit(PhoneSignupSuccessState(phoneRegisterSuccessResponse));
      }
      if (value.data['status'] == false) {
        phoneRegisterFailedResponse = FailedResponseModel.fromJson(value.data);
        emit(PhoneSignupErrorState(value.data['msg']));
      }
    }).catchError((error) {
      log(error.toString());
    });
  }

  FailedResponseModel loginFailedResponse;
  RegisterSuccessModel loginSuccessResponse;

  void login({String phone, String password, String language}) async {
    //await getDeviceToken();

    _pushNotificationManagger.init().then((value) {
      log("firebase_id                            $MobToken");

      emit(LoginLoadingState());
      Mhelper.postData(url: authLogin, data: {
        "phone": phone,
        "lang": language,
        "firebase_id": MobToken,
        "password": password,
      }).then((value) {
        log(value.data.toString());
        if (value.data['status'] == true) {
          loginSuccessResponse = RegisterSuccessModel.fromJson(value.data);
          CacheHelper.setData(key: 'id', value: loginSuccessResponse.data.id);
          CacheHelper.setData(
              key: 'token', value: loginSuccessResponse.data.token);
          CacheHelper.setData(
              key: 'userInfo',
              value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
          emit(LoginSuccessState(loginSuccessResponse));
        }
        if (value.data['status'] == false) {
          loginFailedResponse = FailedResponseModel.fromJson(value.data);
          emit(LoginErrorState(value.data['msg']));
        }
      }).catchError((error) {
        emit(LoginErrorState(error.toString()));
        log(error.toString());
      });
    });
  }

  void logOut({@required BuildContext context}) {
    emit(LogoutLoadingState());
    Mhelper.postData(
      url: authLogOut,
      data: {
        'token': kToken,
      },
      token: kToken,
    ).then((value) {
      log(value.statusCode.toString());
      if (value.data['status']) {
        CacheHelper.clearCache();
        kToken = null;
      }
      log('token after logout is: $kToken');
      emit(LogoutSuccessState());
      navigateAndFinish(context, HomeLayout());
    }).catchError((error) {
      log('Logout error ==> ${error}');
      emit(LogoutErrorState());
    });
  }
}
