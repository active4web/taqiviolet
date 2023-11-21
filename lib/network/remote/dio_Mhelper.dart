import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:safsofa/shared/constants.dart';

class Mhelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: MBaseUrl,
        receiveDataWhenStatusError: true,
        followRedirects: false,
   /*     responseType: ResponseType.plain,*/
      ),
    );
    dio.interceptors.add(LogInterceptor(
      responseBody: true,
      error: true,
      requestHeader: false,
      responseHeader: false,
      requestBody: true,
      request: true,
    ));
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    dynamic data,
    token,
  }) async {
    dio.options.headers["authorization"] = "Bearer $token";
    return await dio.get(
      url,
      queryParameters: query,
      data:data,
    );
  }

  static Future<dynamic> postData(
      {required String url,
      Map<String, dynamic>? query,
        dynamic data,
      token}) async {
   try{
     dio.options.headers["authorization"] = "Bearer $token";
     return await dio.post(
       url,
       queryParameters: query,
       data: data,
     );
   }catch(e){
     print("errrrrrrrrrrrrrrrrrrrror$e");

   }
  }

  static Future<dynamic> postRawData(
      {required String url,
      Map<String, dynamic>? query,
      @required dynamic data,
      token}) async {
    dio.options.headers["authorization"] = "Bearer $token";
    return dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
