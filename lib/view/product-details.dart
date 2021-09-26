import 'package:flutter/material.dart';
import 'package:getx_example/data/model/product.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';
import 'package:getx_example/view/widgets/menu/product-item.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: product.color,
      ),
      body: Column(
        children: [
          _getHeader(),
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
              onPressed: () {},
            ),
          ),
          SizedBox(height: 16.0)
        ],
      ),
    );
  }

  Widget _getHeader() {
    return AspectRatio(
      aspectRatio: 6 / 5,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ProductItem(
            product: product,
            aspectRatio: 6 / 5,
          ),
          Positioned(
            bottom: -24,
            child: Container(
              height: 40.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: product.sizes.length,
                itemBuilder: (context, index) => Container(
                  width: 40.0,
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: CustomText(
                    product.sizes[index],
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                separatorBuilder: (context, index) => SizedBox(
                  width: 8.0,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
