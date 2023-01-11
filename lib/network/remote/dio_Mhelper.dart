import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:safsofa/shared/constants.dart';

class Mhelper {
  static Dio dio;

  static init() {
    dio = Dio(
      
      BaseOptions(
          baseUrl: MBaseUrl,
          receiveDataWhenStatusError: true,
          followRedirects: false,
          
          ),
    );
  }

  static Future<Response> getData(
      {@required url, Map<String, dynamic> query, token}) async {
    dio.options.headers["authorization"] = "Bearer $token";

    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData(
      {String url,
      Map<String, dynamic> query,
      @required Map<String, dynamic> data,
      token}) async {
    dio.options.headers["authorization"] = "Bearer $token";
    return dio.post(
      url,
      queryParameters: query,
      data: FormData.fromMap(data),
    );
  }
}
