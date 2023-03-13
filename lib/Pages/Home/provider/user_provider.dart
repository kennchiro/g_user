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
      "name": user.name,
      "email": user.email,
      "password": user.password,
      "password_confirmation": user.password
    });
    print(response.statusMessage);
    if (response.statusCode == 200) {
      print("wait validation");
    } else {
      addAll();
      Navigator.pop(context);
      EasyLoading.showSuccess("Utilisateur ajout avec succes");
    }
  }

  // edit user
  void editUser({required int id, required User user, context}) async {
    var dio = await ServiceApi.getDio();
    var response = await dio
        .put('${BaseAPI.updateUserInfoEndPoint}$id', data: {"name": user.name});
    if (response.statusCode == 200) {
      await EasyLoading.showSuccess("Modification avec success");
      state = [
        for (final data in state)
          if (data.id == id) user else data,
      ];
    }
  }

  // delete user
  deleteUser({required String email}) {
    state = state.where((user) => user.email != email).toList();
  }

  // active/desactive
  disabledUser({required int id, required bool isActive}) async {
    var dio = await ServiceApi.getDio();

    var response = await dio.put('${BaseAPI.setActiveUserEndPoint}$id',
        data: {"action": isActive ? "active" : "desactive"});
    print(response);
    if (response.statusCode == 200) {
      print(response.data);
      state = [
        for (final data in state)
          if (data.id == id) data.copyWith(isActive: isActive ? 1 : 0) else data
      ];
    }
  }

  // update isAdmin
  setAdmin({required int id, required int isAdmin, context}) async {
    var dio = await ServiceApi.getDio();
    var response = await dio.put('${BaseAPI.setAdminEndPoint}$id',
        data: {"action": isAdmin == 1 ? " active" : "desactive"});
    print(response);
    if (response.statusCode == 200) {
      state = [
        for (final data in state)
          if (data.id == id) data.copyWith(isAdmin: isAdmin) else data
      ];
      Navigator.pop(context);
    }

    //  state = [
    //     for (final data in state)
    //       if (data.id == id) data.copyWith(isAdmin: isAdmin) else data
    //   ];
  }

  updatePassword(String oldPassword, String newPassword) async {
    var dio = await ServiceApi.getDio();
    var response = await dio.put(BaseAPI.updatePasswordUserEndPoint, data: {
      'old_password': oldPassword,
      'new_password': newPassword,
      'new_password_confirmation': newPassword,
    });

    print(response.statusMessage);
    if (response.statusCode == 200) {
      await EasyLoading.showSuccess("Modification avec success");
      // print(response.data['user']);
    } else {
      await EasyLoading.showSuccess("Modification avec success");
    }
  }
}

final userDataProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  return UserNotifier();
});
