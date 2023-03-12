
import 'package:flutter/material.dart';

import '../../Utils/app_color.dart';
import 'widget/signUp_formbuilder.dart';

class SignUpPage extends StatelessWidget {
const SignUpPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
       backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                alignment: Alignment.center,
                child: Icon(
                  Icons.person_pin,
                  color: AppColors.SHADOW,
                  size: MediaQuery.of(context).size.width - 150,
                ),
              ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: const SignUpFormBuilder(),
              ))
        ],
      ),
    );
  }
}