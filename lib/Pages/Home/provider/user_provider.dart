import 'package:g_user/Data/Model/User.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserNotifier extends StateNotifier<List<User>> {
  UserNotifier()
      : super([
          User(
              name: 'Lazaniaina Elie',
              email: 'elie@gmail.com',
              isActive: true,
              created_at: '07 Mars 2023',
              isAdmin: 1),
          User(
              name: 'Tahirintsoa Lynda',
              email: 'lynda@gmail.com',
              isActive: false,
              created_at: '05 Mars 2023',
              isAdmin: 0),
        ]);

  // add new user
  addUser(User user) {
    state = [...state, user];
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
  disabledUser({required String email}) {
    state = [
      for (final data in state)
        if (data.email == email)
          data.copyWith(isActive: !data.isActive!)
        else
          data
    ];
  }
}

final userDataProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  return UserNotifier();
});
