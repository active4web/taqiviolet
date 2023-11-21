import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safsofa/models/failed_request_model.dart';
import 'package:safsofa/models/register_success_model.dart';
import 'package:safsofa/network/local/cache_helper.dart';
import 'package:safsofa/network/remote/dio_Mhelper.dart';
import 'package:safsofa/shared/constants.dart';
import 'package:safsofa/shared/defaults.dart';

import '../../models/cart_models/cart_local_model/cart_local_model.dart';
import '../../screens/home_layout.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  // PushNotificationManagger _pushNotificationManagger =
  //     PushNotificationManagger();

  // bool showPassword = true;
  // IconData passwordIcon = Icons.visibility;
  //
  // void changePasswordVisibility() {
  //   showPassword = !showPassword;
  //   passwordIcon = showPassword
  //       ? Icons.visibility_outlined
  //       : Icons.visibility_off_outlined;
  //   emit(ShowAndHideEmailRegisterPassword());
  // }

  IconData suffixLogin = Icons.visibility_off_outlined;
  bool isPasswordLogin = true;

  void isShowAndHideLoginPassWord() {
    isPasswordLogin = !isPasswordLogin;
    suffixLogin = isPasswordLogin
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideLoginPassword());
  }

  IconData suffixEmailRegisterPassword = Icons.visibility_off_outlined;
  bool isPasswordEmailRegisterPassword = true;

  void isShowAndHideEmailRegisterPassword() {
    isPasswordEmailRegisterPassword = !isPasswordEmailRegisterPassword;
    suffixEmailRegisterPassword = isPasswordEmailRegisterPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideEmailRegisterPassword());
  }

  IconData suffixEmailRegisterConfirmPassword = Icons.visibility_off_outlined;
  bool isPasswordEmailRegisterConfirmPassword = true;

  void isShowAndHideEmailRegisterConfirmPassword() {
    isPasswordEmailRegisterConfirmPassword =
        !isPasswordEmailRegisterConfirmPassword;
    suffixEmailRegisterConfirmPassword = isPasswordEmailRegisterConfirmPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideEmailRegisterConfirmPassword());
  }

  IconData suffixPhoneRegisterPassword = Icons.visibility_off_outlined;
  bool isPasswordPhoneRegisterPassword = true;

  void isShowAndHidePhoneRegisterPassword() {
    isPasswordPhoneRegisterPassword = !isPasswordPhoneRegisterPassword;
    suffixPhoneRegisterPassword = isPasswordPhoneRegisterPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHidePhoneRegisterPassword());
  }

  IconData suffixPhoneRegisterConfirmPassword = Icons.visibility_off_outlined;
  bool isPasswordPhoneRegisterConfirmPassword = true;

  void isShowAndHidePhoneRegisterConfirmPassword() {
    isPasswordPhoneRegisterConfirmPassword =
        !isPasswordPhoneRegisterConfirmPassword;
    suffixPhoneRegisterConfirmPassword = isPasswordPhoneRegisterConfirmPassword
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    emit(ShowAndHideLoginPassword());
  }

  // double password_strength = 0;

  // 0: No password
  // 1/4: Weak
  // 2/4: Medium
  // 3/4: Strong
  //   1:   Great
  // RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  //A function that validate user entered password
  // bool validatePassword(String pass) {
  //   if (pass.isEmpty) {
  //     password_strength = 0;
  //     emit(ShowAndHideEmailRegisterPasswordLoading());
  //   } else if (pass.length < 6) {
  //     password_strength = 1 / 4; //string length less then 6 character
  //     emit(ShowAndHideEmailRegisterPasswordLoading());
  //   } else if (pass.length < 8) {
  //     password_strength = 2 / 4; //string length greater then 6 & less then 8
  //     emit(ShowAndHideEmailRegisterPasswordLoading());
  //   } else {
  //     if (pass_valid.hasMatch(pass)) {
  //       password_strength = 4 / 4;
  //       emit(ShowAndHideEmailRegisterPasswordLoading());
  //       return true;
  //     } else {
  //       password_strength = 3 / 4;
  //       emit(ShowAndHideEmailRegisterPasswordLoading());
  //       return false;
  //     }
  //   }
  //   return false;
  // }


   String MobToken = CacheHelper.getData('FCM');

  // Future<void> getDataInBackground(RemoteMessage message) async {
  //   log("${message.data.toString()}");
  //   showToast(text: "${message.data.toString()}", color: Colors.green);
  // }

  // Future<String> getDeviceToken() async {
  //   String token;
  //   var messaging = FirebaseMessaging.instance;
  //   token = await messaging.getToken();
  //   log("token most:${token}");
  //   MobToken = token;
  //   FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //     log("${event.data.toString()}");
  //     showToast(text: "${event.data.toString()}", color: Colors.green);
  //   });
  //   FirebaseMessaging.onMessage.listen((event) {
  //     log("${event.data.toString()}");
  //     showToast(text: "${event.data.toString()}", color: Colors.green);
  //   });
  //
  //   FirebaseMessaging.onBackgroundMessage(getDataInBackground);
  //   return token;
  // }

  FailedResponseModel? emailRegisterFailedResponse;
  RegisterSuccessModel? emailRegisterSuccessResponse;
  FailedResponseModel? phoneRegisterFailedResponse;
  RegisterSuccessModel? phoneRegisterSuccessResponse;

  void registerWithEmail({
    String? lang,
    String? name,
    String? password,
    String? email,
    String? address,
    //key=1 for phone register
    //key=2 for email register
    String? key,
  }) {
    emit(EmailSignupLoadingState());
    Mhelper.postData(url: '/api/register', data: {
      "lang": "$lang",
      "firebase_id": CacheHelper.getData('FCM'),
      "name": "$name",
      "email": "$email",
      "password": "$password",
      "address": "$address",
      "key": key
    }, query: {
      'lang': kLanguage,
    }).then((value) {
      if (value.data['status'] == true) {
        emailRegisterSuccessResponse = RegisterSuccessModel.fromJson(value.data);
        CacheHelper.setData(
            key: 'userInfo',
            value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
        CacheHelper.setData(
            key: 'token', value: emailRegisterSuccessResponse?.data?.token);
        if (CacheHelper.getData('localCart') != null) {
          addLocalDataOfCartToServer(
              token: (emailRegisterSuccessResponse?.data?.token)!);
        }
        //     CacheHelper.setData(key: 'token', value: emailRegisterSuccessResponse.data.token);
        // kToken = CacheHelper.getData('token');
        // CacheHelper.setData(
        //     key: 'token', value: signupSuccessResponse.data.token);
        // kToken = CacheHelper.getData('token');

        emit(EmailSignupSuccessState(emailRegisterSuccessResponse!));
      }
      if (value.data['status'] == false) {
        // emailRegisterFailedResponse = FailedResponseModel.fromJson(value.data);
        emit(EmailSignupErrorState(value.data['msg']));
      }
    }).catchError((error) {

      log(error.toString());
    });
  }

  void registerWithPhone({
    String? lang,
    String? name,
    String? phone,
    String? password,
    String? address,
    //key=1 for phone register
    //key=2 for email register
    String? key,
  }) {
    emit(PhoneSignupLoadingState());

    Mhelper.postData(url: '/api/register', data: {
      "lang": "$lang",
      "firebase_id": CacheHelper.getData('FCM'),
      "name": "$name",
      "password": "$password",
      "phone": "$phone",
      "address": "$address",
      "key": key
    }, query: {
      'lang': kLanguage,
    }).then((value) {
      if (value.data['status'] == true) {
        phoneRegisterSuccessResponse = RegisterSuccessModel.fromJson(value.data);

        CacheHelper.setData(key: 'userInfo', value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
        CacheHelper.setData(key: 'token', value: phoneRegisterSuccessResponse?.data?.token);
        if (CacheHelper.getData('localCart') != null) {
          addLocalDataOfCartToServer(token: (phoneRegisterSuccessResponse?.data?.token)!);
        }
        //     CacheHelper.setData(key: 'token', value: phoneRegisterSuccessResponse.data.token);
        // kToken = CacheHelper.getData('token');
        // CacheHelper.setData(
        //     key: 'token', value: signupSuccessResponse.data.token);
        // kToken = CacheHelper.getData('token');
        emit(PhoneSignupSuccessState(phoneRegisterSuccessResponse!));
      }
      if (value.data['status'] == false) {
        phoneRegisterFailedResponse = FailedResponseModel.fromJson(value.data);
        emit(PhoneSignupErrorState(value.data['msg']));
      }
    }).catchError((error) {
      log(error.toString());
    });
  }

  FailedResponseModel? loginFailedResponse;
  RegisterSuccessModel? loginSuccessResponse;

  void login({String? phone, String? password, String? language}) async {
    //await getDeviceToken();

    // _pushNotificationManagger.init().then((value) {
    //   log("firebase_id                            $MobToken");

    emit(LoginLoadingState());
    Mhelper.postData(url: authLogin, data: {
      "phone": phone,
      "lang": language,
      "firebase_id": CacheHelper.getData('FCM'),
      "password": password,
    }, query: {
      'lang': kLanguage,
    }).then((value) {
      log(value.data.toString());
      if (value.data['status'] == true) {
        loginSuccessResponse = RegisterSuccessModel.fromJson(value.data);
        CacheHelper.setData(key: 'id', value: loginSuccessResponse?.data?.id);
        CacheHelper.setData(key: 'type', value: loginSuccessResponse?.data?.type);
        CacheHelper.setData(
            key: 'token', value: loginSuccessResponse?.data?.token);
        CacheHelper.setData(
            key: 'userInfo',
            value: jsonEncode(RegisterSuccessModel.fromJson(value.data)));
        if (CacheHelper.getData('localCart') != null) {
          addLocalDataOfCartToServer(
              token: (loginSuccessResponse?.data?.token)!);
        }

        emit(LoginSuccessState(loginSuccessResponse!));
      }
      if (value.data['status'] == false) {
        loginFailedResponse = FailedResponseModel.fromJson(value.data);

         emit(LoginErrorState(value.data['msg']));
      }
    }).catchError((error) {
      emit(LoginErrorState(error.toString()));
      log(error.toString());
    });
    // });
  }

  Future<void> logOut()async {
    print("hhhhhhhhhhhhhhhhhhhhhhhhhh ${ CacheHelper.getData('token')}");
    emit(LogoutLoadingState());
   final response=await Mhelper.postData(
      url: authLogOut,
      data: {
        'firebase_token': CacheHelper.getData('FCM'),
      },
      token: CacheHelper.getData('token'),
    );
    if(response.data['status']){
      emit(LogoutSuccessState());
      print(response.data);
    }else{
      emit(LogoutErrorState());
    }
  }

  void addLocalDataOfCartToServer({required String token}) {
    CartLocalModel data;
    Map<String, dynamic> json = jsonDecode(CacheHelper.getData('localCart'));
    data = CartLocalModel.fromJson(json);

    Mhelper.postRawData(
        url: 'api/AddListToCart',
        data: jsonEncode(data),
        token: token,
        query: {
          'lang': kLanguage,
        }).then((value) {
      log('Bisho==>${value.data}');
      if (value.data['status']) {
        CacheHelper.removeData('localCart');
        CacheHelper.removeData('cartCount');
        cartCount = 0;
      }
    }).catchError((error) {
      log('Error on sending local cart data: ${error}');
    });
  }
}
