import 'dart:async';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../Config/config.dart';
import '../Data/Model/User.dart';
import '../Utils/app_path_provider.dart';
import 'Api/baseApi.dart';
import 'Api/baseUrl.dart';

class ServiceApi {
  //////////////////////////////////////// ['DIO'] //////////////////////////////////////////

  static Future<Dio> getDio() async {
    var accessToken =
        GUserApp.constSharedPreferences?.getString(GUserApp.userToken);

    var dio = Dio(
      BaseOptions(
        connectTimeout: 30000,
        contentType: 'application/json',
        baseUrl: BaseUrl.currentUrl,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
      ),
    );

    // && error.response?.data['message'] == "Expired JWT Token"
    dio.interceptors.addAll([
      InterceptorsWrapper(onRequest: ((options, handler) {
        if (!options.path.contains('http')) {
          // http pour local, https pour online
          options.path = BaseUrl.currentUrl + options.path;
        }
        options.headers['Authorization'] = 'Bearer $accessToken';
        return handler.next(options);
      }), onError: (error, handler) async {
        // check internet connection
        if (error.type == DioErrorType.other &&
            error.error is SocketException) {
          EasyLoading.showInfo('Pas de connexion internet');
        }
        // check timeout
        if (error.type == DioErrorType.connectTimeout &&
            error.error is TimeoutException) {
          EasyLoading.showInfo('Veuillez ressayer ulterieurement');
        }

        return handler.next(error);
      }),
      DioCacheInterceptor(
        options: CacheOptions(
          store: HiveCacheStore(AppPathProvider.path),
          policy: CachePolicy.refreshForceCache,
          hitCacheOnErrorExcept: [],
          maxStale: const Duration(
            days: 1,
          ), //increase number of days for loger cache
          priority: CachePriority.high,
        ),
      ),
    ]);

    // (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //   client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };

    return dio;
  }

  // referesh token
  static Future _refreshToken(Dio dioRefresh, DioError error) async {
    String email =
        GUserApp.constSharedPreferences!.getString(GUserApp.username)!;
    String password =
        GUserApp.constSharedPreferences!.getString(GUserApp.userPassword)!;
    final userModel = User(password: password, email: email);

    //
    await dioRefresh
        .post(BaseAPI.connexionEndPoint, data: userModel.toJson())
        .then((value) {
      var newToken = GUserApp.constSharedPreferences!
          .setString(GUserApp.userToken, value.data['token']);
      error.requestOptions.headers["Authorization"] = "Bearer $newToken";
    });
  }

  //retry
  static Future<Response<dynamic>> _retry(DioError error, Dio dioRetry) async {
    final options = Options(
        method: error.requestOptions.method,
        headers: error.requestOptions.headers);

    var response = await dioRetry.request(error.requestOptions.path,
        data: error.requestOptions.data,
        queryParameters: error.requestOptions.queryParameters,
        options: options);

    return response;
  }
}
