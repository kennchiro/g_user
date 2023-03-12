import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:g_user/Pages/Home/provider/user_provider.dart';
import 'package:g_user/Pages/Home/user_edit_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Data/Model/User.dart';
import '../../../Utils/app_color.dart';

class UserItem extends ConsumerWidget {
  final User user;
  final String title;
  final Function(bool) onChanged;
  final String subtitle;
  final bool value;
  final int isAdmin;

  const UserItem(
      {Key? key,
      required this.title,
      required this.onChanged,
      required this.value,
      required this.isAdmin,
      required this.user,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    delete(context) {
      ref.read(userDataProvider.notifier).deleteUser(email: user.email!);
    }

    final endActionPane = [
      SlidableAction(
          onPressed: delete,
          backgroundColor: AppColors.SHADOW,
          foregroundColor: AppColors.SHADOW_RED,
          icon: Icons.delete,
          label: 'Supp'),
    ];

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: endActionPane,
      ),
      child: ListTile(
        onTap: () {
          Route route = MaterialPageRoute(
              builder: (_) => UserEditPage(
                    user: user,
                  ));
          Navigator.push(context, route);

          print(user.toJson());
        },
        title: Text(title),
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: AppColors.BLUE.withOpacity(0.5),
          child: const Text(
            "R",
            // clientModel.nomsociete.substring(0, 1).toUpperCase(),
            overflow: TextOverflow.fade,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Cree le : $subtitle "),
            Row(
              children: [
                const Text('Role :'),
                const SizedBox(
                  width: 5,
                ),
                Card(
                  color: isAdmin == 1 ? Colors.red : Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(1.5),
                    child: Text(
                      isAdmin == 1 ? 'Admin' : 'Utilisateur',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        trailing: SizedBox(
          width: 80,
          height: 30,
          child: FlutterSwitch(
            activeColor: Colors.green,
            width: 50,
            value: value,
            onToggle: (v) {
              ref
                  .watch(userDataProvider.notifier)
                  .disabledUser(email: user.email!);
            },
          ),
        ),
      ),
    );
  }
}
