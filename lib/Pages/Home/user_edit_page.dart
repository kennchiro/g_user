// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:g_user/Pages/Home/provider/user_provider.dart';
import 'package:g_user/Pages/Home/widget/role_tile.dart';
import 'package:g_user/Widgets/custom_textFieldIcon.dart';
import '../../Config/config.dart';
import '../../Data/Model/User.dart';
import '../../Utils/app_color.dart';
import '../../Widgets/custom_buttonRounded.dart';
import '../../Widgets/custom_passwordField.dart';

class UserEditPage extends StatefulHookConsumerWidget {
  const UserEditPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserEditPageState();
}

class _UserEditPageState extends ConsumerState<UserEditPage> {
  // List<Map<String, dynamic>> role = [
  //   {
  //     "role": "Admin",
  //     "value": 1,
  //   },
  //   {
  //     "role": "Utilisateur",
  //     "value": 0,
  //   }
  // ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var users = ref.watch(userDataProvider);
    var username = GUserApp.constSharedPreferences!.getString(GUserApp.username);
    var currentUser = users.where((element) => element.email == username).first;

    final name = useTextEditingController(text: currentUser.name);
    final email = useTextEditingController(text: currentUser.email);
    final oldPassword = useTextEditingController();
    final newPassword = useTextEditingController();
    final confirmPassword = useTextEditingController();

    // ValueNotifier<Map<String, dynamic>> isAdmin = useState({
    //   "role": currentUser.isAdmin == 1 ? "Admin" : "Utilisateur",
    //   "value": currentUser.isAdmin
    // });

    saveUser() {
      var dateNow = DateTime.now();
      final user = User(
          id: currentUser.id,
          email: email.text,
          name: name.text,
          created_at: dateNow.toString());
      ref
          .read(userDataProvider.notifier)
          .editUser(id: user.id!, user: user, context: context);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.grey,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: const EdgeInsets.all(2.0),
                alignment: Alignment.center,
                color: currentUser.isAdmin == 1 ? Colors.red : Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Text(
                    currentUser.isAdmin == 1 ? 'Admin' : 'Utilisateur',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Modification : ${currentUser.name}',
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: DefaultTabController(
                initialIndex: 0,
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      labelPadding: EdgeInsets.all(4),
                      tabs: [
                        Tab(
                          text: 'Informations',
                        ),
                        Tab(
                          text: 'Changer mot de passe',
                        )
                      ],
                    ),
                    // tab view
                    Expanded(
                      child: TabBarView(
                        children: [
                          ListView(
                            shrinkWrap: true,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CustomTextFieldIcon(
                                initialValue: name.text,
                                controller: name,
                                showPrefixIcon: false,
                                labelText: 'Nom Complet',
                                name: 'name',
                                hintText: 'Votre nom complet',
                                textInputType: TextInputType.name,
                                validation: FormBuilderValidators.required(),
                              ),

                              const SizedBox(
                                height: 15,
                              ),
                              // adress email
                              CustomTextFieldIcon(
                                readOnly: true,
                                initialValue: email.text,
                                showPrefixIcon: false,
                                labelText: 'Adresse email',
                                controller: email,
                                name: 'Identifiant',
                                hintText: 'Entrez votre adresse e-mail',
                                textInputType: TextInputType.emailAddress,
                                validation: FormBuilderValidators.email(),
                              ),

                              const SizedBox(
                                height: 15,
                              ),
                             
                              // admin/user
                              // Row(
                              //   children: [
                              //     const Expanded(
                              //       child: Text(
                              //         'Role',
                              //         style: TextStyle(
                              //             color: Colors.black87,
                              //             fontWeight: FontWeight.w300),
                              //       ),
                              //     ),
                              //     Expanded(
                              //       child: Focus(
                              //         canRequestFocus: true,
                              //         autofocus: true,
                              //         child: FormBuilderDropdown<
                              //             Map<String, dynamic>>(
                              //           initialValue: role
                              //               .where((element) =>
                              //                   element['value'] ==
                              //                   currentUser.isAdmin)
                              //               .first,
                              //           style: TextStyle(
                              //               fontSize: 10,
                              //               color: AppColors.LIGHT_GREY),
                              //           onChanged: (newValue) {
                              //             isAdmin.value = newValue!;
                              //           },
                              //           name: 'role',
                              //           decoration: InputDecoration(
                              //             filled: true,
                              //             fillColor: AppColors.SHADOW,
                              //             border: OutlineInputBorder(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //               borderSide: BorderSide.none,
                              //             ),
                              //           ),
                              //           // initialValue: 'Male',
                              //           allowClear: true,
                              //           hint: const Text('Selectionner un role',
                              //               style: TextStyle(
                              //                 fontSize: 10,
                              //               )),
                              //           validator:
                              //               FormBuilderValidators.required(),
                              //           items: role
                              //               .map((rle) => DropdownMenuItem(
                              //                     onTap: () {
                              //                       FocusScopeNode
                              //                           focusScopeNode =
                              //                           FocusScope.of(context);
                              //                       if (!focusScopeNode
                              //                           .hasPrimaryFocus) {
                              //                         focusScopeNode.unfocus();
                              //                       }
                              //                       print(rle);
                              //                     },
                              //                     value: rle,
                              //                     child: RoleTile(role: rle),
                              //                   ))
                              //               .toList(),
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              const SizedBox(
                                height: 20,
                              ),

                              CustomButtonRounded(
                                fillColor: Colors.green,
                                height: 60,
                                onPressed: () {
                                  saveUser();
                                },
                                textColor: Colors.white,
                                title: 'Enregister',
                                width: 328,
                              ),
                            ],
                          ),
                          ListView(
                            shrinkWrap: true,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              CustomPasswordField(
                                labelText: "Ancien mot de passe",
                                passwordController: oldPassword,
                                validation: FormBuilderValidators.required(),
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              // confirm password
                              CustomPasswordField(
                                labelText: "Nouveau mot de passe",
                                hintText: "Entrez votre nouveau mot de passe",
                                passwordController: newPassword,
                                validation: FormBuilderValidators.required(),
                              ),

                              const SizedBox(
                                height: 15,
                              ),

                              CustomPasswordField(
                                labelText: "Confirmer mot de passe",
                                hintText: "Retapez votre mote passe",
                                passwordController: confirmPassword,
                                validation: FormBuilderValidators.compose([
                                  (val) {
                                    if (val != newPassword.text) {
                                      return 'Mot de passe ne correspond pas';
                                    }
                                    return null;
                                  }
                                ]),
                              ),

                              const SizedBox(
                                height: 20,
                              ),
                              CustomButtonRounded(
                                fillColor: Colors.green,
                                height: 60,
                                onPressed: () async {
                                  print('$oldPassword + $newPassword');
                                  await ref
                                      .read(userDataProvider.notifier)
                                      .updatePassword(
                                          oldPassword.text, newPassword.text);
                                },
                                textColor: Colors.white,
                                title: 'Enregister',
                                width: 328,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // name

            // password
          ],
        ),
      ),
    );
  }
}
