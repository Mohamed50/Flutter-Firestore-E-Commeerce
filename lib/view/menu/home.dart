import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view/widgets/menu/product-item.dart';

class HomePage extends GetWidget<AuthViewModel> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) => ProductItem(
          color: index % 2 == 0 ? Color(0xFFC3E5E4) : Color(0xFFE6E6E6),
        ),
        separatorBuilder: (context, index) => Container(),
      ),
    );
  }
}
