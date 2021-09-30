import 'package:flutter/material.dart';
import 'package:getx_example/view/widgets/auth-header.dart';

class CustomAuthPage extends StatelessWidget {
  final Widget header;
  final Widget body;
  final EdgeInsets? headerPadding;
  final EdgeInsets? bodyPadding;

  const CustomAuthPage({Key? key, required this.header, required this.body, this.headerPadding, this.bodyPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: AuthHeader(
            padding: headerPadding,
            child: header,
          ),
        ),
        Padding(
          padding: bodyPadding!,
          child: body,
        )
      ],
    );
  }
}
