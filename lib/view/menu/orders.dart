import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/order-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class OrdersPage extends GetWidget<OrdersViewModel> {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.builder(
        itemCount: controller.orders.length,
        itemBuilder: (context, index) => ListTile(
          leading: Container(
            color: controller.orders[index].products!.first.product!.color!,
            padding: EdgeInsets.all(8.0),
            child: Image.network(
              controller.orders[index].products!.first.product!.imageUrl!,
              fit: BoxFit.contain,
            ),
          ),
          title: CustomText(
            "${controller.orders[index].products!.length} items",
            fontSize: 20.0,
          ),
          subtitle: CustomText("in delivery"),
          trailing: CustomText(
            "${controller.orders[index].total} \$",
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
