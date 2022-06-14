import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:safsofa/shared/constants.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: MBaseUrl,
      receiveDataWhenStatusError: true,
    ));
  }

  static Future<Response> getData({
    @required String url,
    Map<String, dynamic> query,
  }) async {
    return await dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    String url,
    Map<String, dynamic> query,
    @required var data,
  }) async {
    return dio.post(
      url,
      queryParameters: query,
      data: FormData.fromMap(data),
    );
  }
}
