import 'package:get/get.dart';
import 'package:getx_example/data/model/cart-product.dart';
import 'package:getx_example/data/model/product.dart';

import 'cart-view-model.dart';

class ProductViewModel extends  GetxController{

  ProductModel _product;
  ProductModel get product => _product;

  String? _selectedSize;
  String? get selectedSize => _selectedSize;

  ProductViewModel(this._product) {
    if(_product.name == null)
      fetchProductById(_product.id!);
  }

  void fetchProductById(String id) {
    // To-do fetch product from firebase using id
  }

  selectSize(int index){
    _selectedSize = _product.sizes[index];
    update();
  }

  addProductToCart(){
    CartProductModel cartProduct = CartProductModel.fromMap(product.toMap());
    cartProduct.size = selectedSize;
    cartProduct.productId = product.id;
    if(cartProduct.size != null)
      Get.find<CartViewModel>().addToCart(cartProduct);
    else
      Get.snackbar("Adding product to cart", "please select size first");
  }




}
