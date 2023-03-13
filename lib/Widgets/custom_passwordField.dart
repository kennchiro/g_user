// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../Utils/app_color.dart';

class CustomPasswordField extends HookConsumerWidget {
  final TextEditingController passwordController;
  final dynamic validation;
  final String labelText;
  final String hintText;

  const CustomPasswordField(
      {super.key,
      required this.passwordController,
      required this.validation,
      this.hintText ="Entrez votre mot de passe",
      this.labelText = "Mot de passe"});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final obscureText = useState(true);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 14, bottom: 10),
          child: Text(
            labelText,
            style: const TextStyle(
                color: Colors.black87, fontWeight: FontWeight.w300),
          ),
        ),

        // password field
        FormBuilderTextField(
          validator: validation,
          expands: false,
          obscureText: obscureText.value,
          name: 'password',
          decoration: InputDecoration(
            filled: true,
            hintText:  hintText,
            hintStyle: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            fillColor: AppColors.SHADOW,
            prefixIcon: Icon(Icons.password_rounded,
                color: AppColors.LIGHT_GREY.withOpacity(0.5)),
            suffixIcon: GestureDetector(
              onTap: () {
                obscureText.value = !obscureText.value;
              },
              child: Icon(
                !obscureText.value ? Icons.visibility : Icons.visibility_off,
                color: AppColors.LIGHT_GREY.withOpacity(0.5),
              ),
            ),
            contentPadding: const EdgeInsets.all(5.0),
          ),
          onChanged: (v) {
            passwordController.text = v!;
          },
        ),
      ],
    );
  }
}
