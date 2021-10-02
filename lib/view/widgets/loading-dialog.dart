import 'package:flutter/material.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomText("wait a second")),
        CircularProgressIndicator(),
      ],
    );
  }
}
