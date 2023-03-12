// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButtonRounded extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final double width;
  final double height;
  final Color fillColor;
  final Color textColor;

  const CustomButtonRounded({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.width,
    required this.height,
    required this.fillColor,
    required this.textColor, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: height,
      width: width,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onPressed,
        color: fillColor,
        child: Text(
          title,
          style: TextStyle(color: textColor, fontSize: 15),
        ),
      ),
    );
  }
}
