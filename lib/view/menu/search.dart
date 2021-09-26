import 'package:flutter/material.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomText(
        "Search"
      ),
    );
  }
}
