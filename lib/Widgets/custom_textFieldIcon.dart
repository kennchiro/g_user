import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:nil/nil.dart';

import '../Utils/app_color.dart';

class CustomTextFieldIcon extends StatelessWidget {
  final TextEditingController controller;
  final dynamic validation;
  final String labelText;
  final String name;
  final IconData data;
  final String hintText;
  final TextInputType textInputType;
  final bool showPrefixIcon;
  final bool isObsecure;
  final String initialValue;
  final bool readOnly;

  CustomTextFieldIcon(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.name,
      this.data = Icons.add,
      required this.hintText,
      required this.textInputType,
      this.isObsecure = false,
      this.readOnly = false,
      this.initialValue = '',
      required this.validation,
      this.showPrefixIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        FormBuilderTextField(
          readOnly: readOnly,
          initialValue: initialValue,
            validator: validation,
            name: name,
            keyboardType: textInputType,
            obscureText: isObsecure,
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'OpenSansCondensed'),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: AppColors.SHADOW,
              hintText: hintText,
              contentPadding: const EdgeInsets.all(5.0),
              prefixIcon: showPrefixIcon
                  ? Icon(data, color: AppColors.LIGHT_GREY.withOpacity(0.5))
                  : nil,
            ),
            onChanged: (v) {
              controller.text = v!;
              if (kDebugMode) {
                print(v);
              }
            }),
      ],
    );
  }
}
