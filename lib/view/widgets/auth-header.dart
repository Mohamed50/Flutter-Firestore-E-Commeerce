import 'package:flutter/material.dart';
import 'package:getx_example/utils/color-extension.dart';


class AuthHeader extends StatelessWidget {
  final Widget child;
  final double? height;
  final EdgeInsets? padding;
  const AuthHeader({Key? key, required this.child, this.height, this.padding}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HexColor.fromHex("#07485B"),
              HexColor.fromHex("#010E12"),
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
          ),
          image: DecorationImage(
            image: AssetImage("assets/images/join.png"),
            alignment: Alignment.topRight
          )
      ),
      child: child,
    );
  }
}
