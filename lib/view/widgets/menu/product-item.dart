import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:getx_example/data/model/product.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class ProductItem extends StatelessWidget {
  final ProductModel? product;
  final Color? color;
  const ProductItem({Key? key, this.product, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6/4,
      child: Container(
        color: color,
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Image.asset("assets/images/mask.png", fit: BoxFit.contain,alignment: Alignment.center,)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText("UNEO"),
                    CustomText("Rs 199 Unisex Pack Of 2"),
                  ],
                ),
                IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.heart)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
