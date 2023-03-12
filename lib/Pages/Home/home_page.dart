import 'package:flutter/material.dart';
import 'package:g_user/Pages/Home/provider/user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../Utils/app_color.dart';
import 'widget/user_item.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listUser = ref.watch(userDataProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.person,
          color: Colors.white,
        ),
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'laza@gmail.com',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
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
                        style: TextStyle(color: Colors.black54, fontSize: 24)),
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
                        value: user.isActive!,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/userAddPage');
        },
        tooltip: 'Ajout user',
        child: const Icon(Icons.person_add),
      ), // T
    );
  }
}
