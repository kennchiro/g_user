import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:g_user/Pages/Authentication/provider/authentication_provider.dart';
import 'package:g_user/Widgets/custom_buttonRounded.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../Widgets/custom_textFieldIcon.dart';

class ForgotPasswordPage extends HookConsumerWidget {
  const ForgotPasswordPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var email = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.grey,
          ),
        ),
        title: const Text(
          'Réinitialiser le mot de passe',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // email field
            CustomTextFieldIcon(
              labelText: 'Adresse email',
              controller: email,
              name: 'Identifiant',
              data: Icons.email,
              hintText: 'Entrez votre adresse e-mail',
              textInputType: TextInputType.emailAddress,
              validation: FormBuilderValidators.email(),
            ),

            const SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButtonRounded(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  title: 'Annuler',
                  width: 150,
                  height: 40,
                  fillColor: Colors.white,
                  textColor: Colors.black,
                ),
                CustomButtonRounded(
                    onPressed: () {
                      ref
                          .read(authenticationProvider)
                          .forgotPassword(email.text);
                    },
                    title: 'Valider',
                    width: 150,
                    height: 40,
                    fillColor: Colors.green,
                    textColor: Colors.white),
              ],
            )
          ],
        ),
      ),
    );
  }
}
