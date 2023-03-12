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

import '../../Data/Model/User.dart';
import '../../Utils/app_color.dart';
import '../../Widgets/custom_buttonRounded.dart';
import '../../Widgets/custom_passwordField.dart';

class UserEditPage extends StatefulHookConsumerWidget {
  final User user;

  const UserEditPage({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserEditPageState();
}

class _UserEditPageState extends ConsumerState<UserEditPage> {
  final formKey = GlobalKey<FormBuilderState>();

  List<Map<String, dynamic>> role = [
    {
      "role": "Admin",
      "value": 1,
    },
    {
      "role": "Utilisateur",
      "value": 0,
    }
  ];

  @override
  Widget build(BuildContext context) {
    final name = useTextEditingController(text: widget.user.name);
    final email = useTextEditingController(text: widget.user.email);
    final password = useTextEditingController();
    final confirmPassword = useTextEditingController();
    final isActive = useState(widget.user.isActive);
    ValueNotifier<Map<String, dynamic>> isAdmin = useState({
      "role": widget.user.isAdmin == 1 ? "Admin" : "Utilisateur",
      "value": widget.user.isAdmin
    });

    saveUser() {
      formKey.currentState!.save();
      if (formKey.currentState!.validate()) {
        var dateNow = DateTime.now();
        final user = User(
            email: email.text,
            name: name.text,
            password: password.text,
            isAdmin: isAdmin.value['value'],
            isActive: isActive.value,
            created_at: dateNow.toString());
        ref
            .read(userDataProvider.notifier)
            .editUser(email: email.text, user: user);
        Navigator.pop(context);
      }
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
                color: widget.user.isAdmin == 1 ? Colors.red : Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Text(
                    widget.user.isAdmin == 1 ? 'Admin' : 'Utilisateur',
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
            'Modification : ${widget.user.name}',
            style: const TextStyle(color: Colors.black87),
          ),
        ),
        body: FormBuilder(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            children: [
              // name
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
              //is active
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Activer/Desactiver',
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    width: 80,
                    height: 30,
                    child: FlutterSwitch(
                      activeColor: Colors.green,
                      width: 50,
                      value: isActive.value == 1 ? true : false ,
                      onToggle: (v) {
                          isActive.value = v == true ? 1 : 0;
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              // admin/user
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Role',
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.w300),
                    ),
                  ),
                  Expanded(
                    child: Focus(
                      canRequestFocus: true,
                      autofocus: true,
                      child: FormBuilderDropdown<Map<String, dynamic>>(
                        initialValue: role
                            .where((element) =>
                                element['value'] == widget.user.isAdmin)
                            .first,
                        style: TextStyle(
                            fontSize: 10, color: AppColors.LIGHT_GREY),
                        onChanged: (newValue) {
                          isAdmin.value = newValue!;
                        },
                        name: 'role',
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.SHADOW,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        // initialValue: 'Male',
                        allowClear: true,
                        hint: const Text('Selectionner un role',
                            style: TextStyle(
                              fontSize: 10,
                            )),
                        validator: FormBuilderValidators.required(),
                        items: role
                            .map((rle) => DropdownMenuItem(
                                  onTap: () {
                                    FocusScopeNode focusScopeNode =
                                        FocusScope.of(context);
                                    if (!focusScopeNode.hasPrimaryFocus) {
                                      focusScopeNode.unfocus();
                                    }
                                    print(rle);
                                  },
                                  value: rle,
                                  child: RoleTile(role: rle),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),

              // password

              CustomPasswordField(
                isConfirm: false,
                passwordController: password,
                validation: FormBuilderValidators.required(),
              ),

              const SizedBox(
                height: 15,
              ),

              // confirm password
              CustomPasswordField(
                isConfirm: true,
                passwordController: confirmPassword,
                validation: FormBuilderValidators.compose([
                  (val) {
                    if (val != password.text) {
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
                onPressed: () {
                  saveUser();
                },
                textColor: Colors.white,
                title: 'Enregister',
                width: 328,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
