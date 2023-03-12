import 'package:flutter/material.dart';
import 'package:g_user/Config/config.dart';
import 'package:g_user/Pages/Authentication/provider/authentication_provider.dart';
import 'package:g_user/Pages/Home/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:nil/nil.dart';
import '../../Utils/app_color.dart';
import 'widget/user_item.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(userDataProvider.notifier).addAll();
    super.initState();
  }

  var name = GUserApp.constSharedPreferences!.getString(GUserApp.username);
  var isAdmin = GUserApp.constSharedPreferences!.getInt(GUserApp.isAdmin);

  @override
  Widget build(BuildContext context) {
    var listUser = ref.watch(userDataProvider);
    var parts = name!.split('@');

    return Scaffold(
        appBar: AppBar(
          leading: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            parts[0],
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                ref.read(authenticationProvider).logOut(context);
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Nos Utilisateurs',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 24)),
                      Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: AppColors.SHADOW,
                        ),
                        child: Text('${listUser.length}'),
                      ),
                    ],
                  ),
                  const Divider()
                ],
              ),
            ),
            listUser.isEmpty
                ? const Center(
                    child: Text('Pas de donnees'),
                  )
                : Expanded(
                    child: ListView.separated(
                      separatorBuilder: (_, index) => const Divider(),
                      itemCount: listUser.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8.0),
                      itemBuilder: (_, index) {
                        var user = listUser[index];
                        return UserItem(
                          title: user.name!,
                          value: user.isActive == 1 ? true : false,
                          onChanged: (bool ative) {},
                          subtitle: user.created_at!,
                          isAdmin: user.isAdmin!,
                          user: user,
                        );
                      },
                    ),
                  )
          ],
        ),
        floatingActionButton: isAdmin == 1
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/userAddPage');
                },
                tooltip: 'Ajout user',
                child: const Icon(Icons.person_add),
              )
            : nil // T
        );
  }
}
