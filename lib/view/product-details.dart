import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/config/const.dart';
import 'package:getx_example/data/model/product.dart';
import 'package:getx_example/view-model/product-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';
import 'package:getx_example/view/widgets/menu/product-item.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductViewModel(product));
    return GetBuilder<ProductViewModel>(
      builder: (controller) {
        ProductModel product = controller.product;
        return Visibility(
          visible: product.name != null,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: product.color,
            ),
            body: Column(
              children: [
                _getHeader(controller.selectedSize),
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
                    child: CustomText(
                      product.description!,
                      fontSize: 16.0,
                      height: 1.6,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: CustomButton(
                    padding: EdgeInsets.all(16.0),
                    text: "Add To Cart",
                    onPressed: Get.find<ProductViewModel>().addProductToCart,
                  ),
                ),
                SizedBox(height: 16.0)
              ],
            ),
          ),
          replacement: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _getHeader(String? selectedSize) {
    return AspectRatio(
      aspectRatio: 1.1,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            children: [
              Expanded(
                child: ProductItem(
                  product: product,
                  aspectRatio: 6 / 5,
                ),
              ),
              Container(height: 24.0,)
            ],
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 40.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: product.sizes.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () => Get.find<ProductViewModel>().selectSize(index),
                  child: Container(
                    width: 40.0,
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selectedSize != null && product.sizes[index] == selectedSize ? primaryColor : Colors.grey.shade200,
                    ),
                    child: CustomText(
                      product.sizes[index],
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  width: 8.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
