import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:g_user/Data/Model/User.dart';
import 'package:g_user/Services/serviceAppi.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Services/Api/baseApi.dart';

class UserNotifier extends StateNotifier<List<User>> {
  UserNotifier() : super([]);

  //
  addAll() async {
    var dio = await ServiceApi.getDio();
    var response = await dio.get(BaseAPI.getUserInfoEndPoint);
    List<dynamic> users = response.data;
    var listUser = users.map((e) => User.fromMap(e)).toList();

    if (response.statusCode == 200) {
      state = listUser;
      print(response.data);
    }
  }

  // add new user
  addUser(User user, context) async {
    var dio = await ServiceApi.getDio();
    var response = await dio.post(BaseAPI.addUserInfoEndPoint, data: {
      'name': user.name,
      'email': user.email,
      'password': user.password,
      "password_confirmation": user.password
    });
    if (response.statusCode == 200) {
      print("wait validation");
    } else {
      addAll();
      Navigator.pop(context);
      EasyLoading.showSuccess("Utilisateur ajout avec succes");
    }
  }

  // edit user
  void editUser({required String email, required User user}) {
    state = [
      for (final data in state)
        if (data.email == email) user else data,
    ];
  }

  // delete user
  deleteUser({required String email}) {
    state = state.where((user) => user.email != email).toList();
  }

  // active/desactive
  disabledUser({required String email, required int isActive}) {
    state = [
      for (final data in state)
        if (data.email == email)
          data.copyWith(isActive: data.isActive!)
        else
          data
    ];
  }
}

final userDataProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  return UserNotifier();
});
