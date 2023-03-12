import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:g_user/Data/Model/User.dart';

import '../../../Services/serviceAppi.dart';

class ServiceApiRepository {
  // get list by there type
  Future<List<T>> getListFromApi<T>(String endPointUrl) async {
    var dioInterceptor = await ServiceApi.getDio();
    Response? response;
    dynamic responseData;

    try {
      response = await dioInterceptor.get(endPointUrl);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    if (response!.data.runtimeType == String) {
      responseData = jsonDecode(response.data);
    } else {
      responseData = response.data;
    }

    List<dynamic> data = responseData;
    List<T> result = [];

    switch (T) {
      case User:
        result = data.map((e) => User.fromMap(e)).cast<T>().toList();
        break;
      default:
        result = [];
    }

    return result;
  }

  // post
  static Future<Response> postApi(String endPointUrl, {dynamic payload}) async {
    var dioInterceptor = await ServiceApi.getDio();
    Response? response;
    try {
      response = await dioInterceptor.post(endPointUrl, data: payload);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return response!;
  }
}
