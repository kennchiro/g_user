import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g_user/Pages/Home/provider/user_provider.dart';
import 'package:g_user/Pages/Home/widget/role_tile.dart';
import 'package:g_user/Widgets/custom_textFieldIcon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Data/Model/User.dart';
import '../../Utils/app_color.dart';
import '../../Widgets/custom_buttonRounded.dart';
import '../../Widgets/custom_passwordField.dart';

class UserAddPage extends StatefulHookConsumerWidget {
  const UserAddPage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserAddPageState();
}

class _UserAddPageState extends ConsumerState<UserAddPage> {
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
    final name = useTextEditingController();
    final email = useTextEditingController();
    final password = useTextEditingController();
    final confirmPassword = useTextEditingController();
    final isActive = useState(false);
    final isAdmin = useState({});

    saveUser()  {
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
        ref.read(userDataProvider.notifier).addUser(user);
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
              )),
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: const Text(
            'Ajout nouveau utilisateur',
            style: TextStyle(color: Colors.black87),
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
                      value: isActive.value,
                      onToggle: (v) {
                        
                        isActive.value = v;
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
