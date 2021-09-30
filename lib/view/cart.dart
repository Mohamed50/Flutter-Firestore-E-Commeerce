import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/cart-view-model.dart';
import 'package:getx_example/view/widgets/cart-item.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';
import 'widgets/customs/custom-text.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        title: CustomText("Cart"),
      ),
      body: GetBuilder<CartViewModel>(
          init: Get.find<CartViewModel>(),
          builder: (controller) => Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.all(24.0),
                      itemCount: controller.cart.length,
                      itemBuilder: (context, index) => CartItem(
                        product: controller.cart[index],
                        index: index,
                      ),
                      separatorBuilder: (context, index) => Divider(
                        height: 32.0,
                        thickness: 1,
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.white,
                    margin: EdgeInsets.all(0.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(32.0))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText("Total price:", fontSize: 24.0,),
                              CustomText("${controller.totalPrice} \$", fontSize: 24.0, fontWeight: FontWeight.w700,),
                            ],
                          ),
                          SizedBox(height: 16.0),
                          CustomButton(
                            text: "Check out",
                            padding: EdgeInsets.all(16.0),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
    );
  }
}
