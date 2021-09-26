import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  const CustomText(this.text ,{Key? key,  this.color, this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      fontSize: fontSize,
      color: color
    ),
    );
  }
}
