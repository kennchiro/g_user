import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Utils/app_color.dart';
import '../Utils/app_path_provider.dart';

class GUserApp {

  // for user info and other
  static SharedPreferences? constSharedPreferences;

  // user info
  static const String userId = 'userId';
  static const String username = 'email';
  static const String userPassword = 'userPassword';
  static const String userToken = 'token';


  // init all main method
  static initMain() async {
    EasyLoading.removeAllCallbacks();
    await GUserApp.configLoading();
    GUserApp.constSharedPreferences = await SharedPreferences.getInstance();
    await AppPathProvider.initPath();
  }

  static Future configLoading() async {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.ring
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 30.0
      ..radius = 10.0
      ..progressColor = Colors.white
      ..backgroundColor = AppColors.PRIMARY_COLOR
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
  }
}
