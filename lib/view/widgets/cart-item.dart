import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/model/cart-product.dart';
import 'package:getx_example/view-model/cart-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class CartItem extends StatelessWidget {
  final CartProductModel product;
  final int index;

  const CartItem({Key? key, required this.product, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.9,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              color: product.color,
              padding: EdgeInsets.all(16.0),
              child: Image.network(
                product.imageUrl != null ? product.imageUrl! : "",
                fit: BoxFit.contain,
                colorBlendMode: BlendMode.dstOver,
              ),
            ),
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    product.name!,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        "${product.price} \$",
                        fontSize: 14.0,
                      ),
                      CustomText(
                        "Size: ${product.size}",
                        fontSize: 14.0,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () => Get.find<CartViewModel>().increaseQuantity(index),
                          child: Icon(FontAwesomeIcons.plusSquare)),
                      CustomText(
                        product.quantity.toString(),
                        fontWeight: FontWeight.w900,
                        fontSize: 24.0,
                      ),
                      InkWell(
                          onTap: () => Get.find<CartViewModel>().decreaseQuantity(index),
                          child: Icon(FontAwesomeIcons.minusSquare)),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
