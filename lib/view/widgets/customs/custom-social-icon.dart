import 'package:flutter/material.dart';
import 'package:getx_example/config/const.dart';
import 'custom-text.dart';

class CustomIconButtonWithText extends StatelessWidget {
  final String? text;
  final IconData iconData;
  final VoidCallback? onPressed;
  final double width;
  final Color color;
  final Color iconColor;
  final EdgeInsets? padding;
  final double borderRadius;
  final double? elevation;
  const CustomIconButtonWithText({Key? key,  required this.iconData, this.text, this.onPressed, this.color : primaryColor, this.padding, this.borderRadius : 8.0, this.width : double.infinity, this.iconColor : iconsColor, this.elevation,}) : super(key: key);

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
          elevation: elevation,
            primary: color, padding: padding,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius))
        ),
      ),
    );
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onPressed;
  final Color color;
  final Color iconColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  const CustomIconButton({Key? key,  required this.iconData, this.onPressed, this.color : primaryColor, this.padding, this.borderRadius : 8.0, this.iconColor : iconsColor,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(iconData, color: iconColor,),
        padding: padding!,
      ),
    );
  }
}
