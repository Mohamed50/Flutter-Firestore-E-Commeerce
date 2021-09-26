import 'package:flutter/material.dart';
import 'package:getx_example/config/const.dart';
import 'custom-text.dart';

class CustomIconButton extends StatelessWidget {
  final String? text;
  final IconData iconData;
  final VoidCallback? onPressed;
  final double width;
  final Color color;
  final Color iconColor;
  final EdgeInsets? padding;
  final double borderRadius;
  const CustomIconButton({Key? key,  required this.iconData, this.text, this.onPressed, this.color : primaryColor, this.padding, this.borderRadius : 8.0, this.width : double.infinity, this.iconColor : iconsColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(iconData, color: iconColor,),
            SizedBox(width: 8.0,),
            text != null ? CustomText(text!, color: iconColor,) : Container(),
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: color, padding: padding,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))
        ),
      ),
    );
  }
}
