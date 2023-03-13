import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../Data/Model/User.dart';
import '../../../Utils/app_color.dart';
import '../../../Widgets/custom_passwordField.dart';
import '../../../Widgets/custom_textFieldIcon.dart';
import '../provider/authentication_provider.dart';

class LoginFormBuilder extends StatefulHookConsumerWidget {
  const LoginFormBuilder({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LoginFormBuilderState();
}

class _LoginFormBuilderState extends ConsumerState<LoginFormBuilder> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController();
    final password = useTextEditingController();

    // signIn function
    signIn() async {
      formKey.currentState!.save();
      if (formKey.currentState!.validate()) {
        final user = User(email: email.text, password: password.text);
        await ref.read(authenticationProvider).signIn(user, context);
      }
    }

    return FormBuilder(
      key: formKey,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          children: [
            const Center(
              child: Text(
                'Connexion',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

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

            CustomPasswordField(
              passwordController: password,
              validation: FormBuilderValidators.required(),
            ),

            Container(
              padding: const EdgeInsets.only(top: 5),
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signUpPage');
                  if (kDebugMode) {
                    print('create account');
                  }
                },
                child: Text(
                  'Créer un compte',
                  style: TextStyle(
                      color: AppColors.PRIMARY_COLOR,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),

            Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, bottom: 10),
                  color: Colors.transparent,
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    color: const Color.fromARGB(255, 34, 107, 15),
                    child: Text(
                      'Connexion',
                      style: TextStyle(color: AppColors.WHITE),
                    ),
                    onPressed: () async {
                      await signIn(); //  Navigator.pushReplacementNamed(context, '/homePage');
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forgotPasswordPage');
                      if (kDebugMode) {
                        print('mot de passe oublier');
                      }
                    },
                    child: Text(
                      'Mot de passe oublié ?',
                      style: TextStyle(color: AppColors.PRIMARY_COLOR),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
