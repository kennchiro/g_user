import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../Config/config.dart';
import '../../../Data/Model/User.dart';
import '../../../Services/Api/baseApi.dart';
import '../../../Services/serviceAppi.dart';

class Authentication {
  // login user
  Future signIn(User user, context) async {
    var dioInterceptor = await ServiceApi.getDio();

    await EasyLoading.show(status: 'Veuillez patienter');

    try {
      final response =
          await dioInterceptor.post(BaseAPI.connexionEndPoint, data: {
        "email": user.email,
        "password": user.password,
      });

      if (response.statusCode == 200) {
        await GUserApp.constSharedPreferences!
            .setString(GUserApp.userToken, response.data['user']['api_token']);
        await GUserApp.constSharedPreferences!
            .setInt(GUserApp.isAdmin, response.data['user']['isAdmin']);
        await GUserApp.constSharedPreferences!
            .setString(GUserApp.username, user.email!);
        await GUserApp.constSharedPreferences!
            .setString(GUserApp.userPassword, user.password!);
        await EasyLoading.showSuccess('Bienvenu ${user.email}');
        // await getUserId(user.email!);
        await Navigator.pushReplacementNamed(context, '/homePage');

        if (kDebugMode) {
          print(response.data['token']);
        }
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 401) {
        EasyLoading.showInfo('Mot de passe incorrect ou email invalide');
      }
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // signUp user
  Future signUp(User user, context) async {
    var dioInterceptor = Dio();

    await EasyLoading.show(
      status: 'Veuillez patienter',
    );

    try {
      final response =
          await dioInterceptor.post(BaseAPI.creerCompteEndPoint, data: {
        "name": user.name,
        "email": user.email,
        "password": user.password,
        "password_confirmation": user.password
      });

      // bool isSuccess = await response.data['success'];
      // String message = await response.data['message'];

      if (response.statusCode == 200) {
        await EasyLoading.showSuccess("Enregistee avec success");
        // await signIn(user, context);
      } else {
        await EasyLoading.showSuccess("Veuillez verifier votre email");
        Navigator.pop(context);
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //get user id
  _getUserId(String email) async {
    var dioInterceptor = await ServiceApi.getDio();
    try {
      final response =
          await dioInterceptor.get('${BaseAPI.getUserInfoEndPoint}/$email');
      var data = response.data;
      if (response.statusCode == 200) {
        GUserApp.constSharedPreferences!.setInt(GUserApp.userId, data['id']);
        if (kDebugMode) {
          print(data);
        }
      }
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  // LOGOUT
  logOut(context) async {
    await GUserApp.constSharedPreferences!.remove(GUserApp.isAdmin);
    await GUserApp.constSharedPreferences!
        .remove(GUserApp.userToken)
        .whenComplete(() {
      Navigator.pushNamedAndRemoveUntil(
          context, '/signInPage', (route) => false);
    });
  }
}

// PROVIDER AUTH
final authenticationProvider = Provider.autoDispose<Authentication>((ref) {
  return Authentication();
});
