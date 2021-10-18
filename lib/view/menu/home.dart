import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/home-view-model.dart';
import 'package:getx_example/view/widgets/menu/product-item.dart';

class HomePage extends GetWidget<HomeViewModel> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('home-page'),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.products.length,
          itemBuilder: (context, index) => ProductItem(
            product: controller.products[index],
          ),
        ),
      ),
    );
  }
}
