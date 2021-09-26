import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final double? height;
  final FontWeight? fontWeight;

  const CustomText(this.text,
      {Key? key, this.color, this.fontSize, this.fontWeight, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontWeight: fontWeight,
        height: height
      ),
    );
  }
}
