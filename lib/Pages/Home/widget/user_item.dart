import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:g_user/Pages/Home/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nil/nil.dart';
import '../../../Config/config.dart';
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
    var checkAdmin = GUserApp.constSharedPreferences!.getInt(GUserApp.isAdmin);
    var email = GUserApp.constSharedPreferences!.getString(GUserApp.username);

    showAdmin() async {
      await showModal(
        context: context,
        configuration: const FadeScaleTransitionConfiguration(
          transitionDuration: Duration(seconds: 1),
        ),
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 0.5,
                sigmaY: 0.5,
              ),
              child: Container(
                height: 150,
                width: 250,
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Modifier role :'),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    Card(
                      shape: Border.all(
                        color: user.isAdmin == 1 ? Colors.green : Colors.white,
                      ),
                      child: ListTile(
                        onTap: () {
                          ref.read(userDataProvider.notifier).setAdmin(
                              id: user.id!, isAdmin: 1, context: context);
                        },
                        title: const Text('Admin'),
                        trailing: user.isAdmin == 1
                            ? const Icon(
                                Icons.check,
                                color: Colors.green,
                              )
                            : nil,
                      ),
                    ),
                    Expanded(
                      child: Card(
                        shape: Border.all(
                          color:
                              user.isAdmin == 0 ? Colors.green : Colors.white,
                        ),
                        child: ListTile(
                          onTap: () {
                            ref.read(userDataProvider.notifier).setAdmin(
                                id: user.id!, isAdmin: 0, context: context);
                          },
                          title: const Text('Utilisateur'),
                          trailing: user.isAdmin == 0
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : nil,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }

    return ListTile(
      onTap: () async {
        checkAdmin == 1 ? await showAdmin() : null;
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
      trailing: checkAdmin == 1
          ? SizedBox(
              width: 80,
              height: 30,
              child: FlutterSwitch(
                activeColor: Colors.green,
                width: 50,
                value: user.isActive == 1 ? true : false,
                onToggle: (v) async {
                  await ref
                      .read(userDataProvider.notifier)
                      .disabledUser(id: user.id!, isActive: v);
                },
              ),
            )
          // : user.email == email
          //     ? SizedBox(
          //         width: 80,
          //         height: 30,
          //         child: FlutterSwitch(
          //           activeColor: Colors.green,
          //           width: 50,
          //           value: user.isActive == 1 ? true : false,
          //           onToggle: (v) async {
          //             await ref
          //                 .read(userDataProvider.notifier)
          //                 .disabledUser(id: user.id!, isActive: v);
          //           },
          //         ),
          //       )
          : nil,
    );
  }
}
