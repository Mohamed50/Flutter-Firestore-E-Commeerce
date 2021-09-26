import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_example/data/model/product.dart';
import 'package:getx_example/view/product-details.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class ProductItem extends StatelessWidget {
  final double? aspectRatio;
  final ProductModel product;
  final bool clickable;

  const ProductItem({Key? key, required this.product, this.aspectRatio : 3/2, this.clickable : true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !clickable ? null : ()=> Get.to(ProductDetailsPage(product: product)),
      child: AspectRatio(
        aspectRatio: aspectRatio!,
        child: Container(
          color: product.color,
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Image.network(
                  product.imageUrl!,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        product.name!,
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 8.0),
                      CustomText(product.details!),
                    ],
                  ),
                  IconButton(
                      onPressed: () {}, icon: Icon(FontAwesomeIcons.heart)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
