import 'package:flutter/material.dart';
import 'package:getx_example/config/const.dart';

import 'custom-text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final Color color;
  final EdgeInsets? padding;
  final double borderRadius;
  const CustomButton({Key? key, required this.text, this.onPressed, this.color : primaryColor, this.padding, this.borderRadius : 8.0, this.width : double.infinity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: CustomText(text),
        style: ElevatedButton.styleFrom(
            primary: color, padding: padding,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))
        ),
      ),
    );
  }
}
