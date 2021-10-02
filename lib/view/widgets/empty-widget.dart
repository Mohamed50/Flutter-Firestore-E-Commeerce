import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getx_example/config/const.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class EmptyWidget extends StatelessWidget {
  final double padding;
  final String assetName;
  final String text;

  const EmptyWidget({Key? key, required this.assetName, required this.text, this.padding : 0.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          Expanded(child: SvgPicture.asset(assetName)),
          CustomText(text, color: primaryColor, fontSize: 24.0,)
        ],
      ),
    );
  }
}
