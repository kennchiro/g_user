import 'package:flutter/material.dart';
import 'package:g_user/Utils/app_color.dart';

import 'widget/login_formBuilder.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.person_pin,
                  color: AppColors.SHADOW,
                  size: MediaQuery.of(context).size.width - 150,
                ),
              ),
            ),
            const Expanded(
              flex: 3,
              child: LoginFormBuilder(),
            )
          ],
        ),
      ),
    );
  }
}
