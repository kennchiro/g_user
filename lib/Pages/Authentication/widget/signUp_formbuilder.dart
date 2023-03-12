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

class SignUpFormBuilder extends StatefulHookConsumerWidget {
  const SignUpFormBuilder({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SignUpFormBuilderState();
}

class _SignUpFormBuilderState extends ConsumerState<SignUpFormBuilder> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final email = useTextEditingController();
    final password = useTextEditingController();
    final confirmPassword = useTextEditingController();

    // function sign up
    signUp() async {
      formKey.currentState!.save();
      if (formKey.currentState!.validate()) {
        final user = User(email: email.text, password: password.text);
        await ref.read(authenticationProvider).signUp(user, context);
      }
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: FormBuilder(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "S'inscrire",
                  style: TextStyle(
                     fontSize: 40.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                CustomTextFieldIcon(
                  labelText: "Adresse email",
                  controller: email,
                  name: 'address',
                  data: Icons.email,
                  hintText: "Entrez votre adresse e-mail",
                  textInputType: TextInputType.emailAddress,
                  validation: FormBuilderValidators.email(),
                ),

                // password
                CustomPasswordField(
                  isConfirm: false,
                  passwordController: password,
                  validation: FormBuilderValidators.required(),
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

                Container(
                  padding: const EdgeInsets.only(top: 10),
                  alignment: Alignment.centerLeft,

                  child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signInPage');
                      if (kDebugMode) {
                        print('already have account ?');
                      }
                    },
                    child: Text(
                      "Vous avez déjà un compte ? Connexion",
                      style: TextStyle(
                          color: AppColors.PRIMARY_COLOR,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
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
                      'Créer un compte',
                      style: TextStyle(color: AppColors.WHITE),
                    ),
                    onPressed: () async {
                      await signUp();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
