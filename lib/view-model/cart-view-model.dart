import 'package:get/get.dart';
import 'package:getx_example/data/controller/db-helper.dart';
import 'package:getx_example/data/model/cart-product.dart';

class CartViewModel extends GetxController{

  DBHelper _dbHelper = DBHelper.dbHelper;

  List<CartProductModel> _cart = <CartProductModel>[];
  List<CartProductModel> get cart => _cart;

  RxDouble _totalPrice = 0.0.obs;
  double get totalPrice => _totalPrice.value;

  CartViewModel(){
    fetchAllProducts();
  }

  Future fetchAllProducts() async {
    var result = await _dbHelper.fetchAllProducts();
    _cart.addAll(result.map((element) => CartProductModel.fromMap(element)));
    update();
    calculatePrice();
  }

  updateProduct(CartProductModel productModel) async {
    await _dbHelper.updateProduct(productModel);
  }

  deleteProduct(CartProductModel productModel) async {
    await _dbHelper.deleteProduct(productModel.id!);
  }


  Future increaseQuantity(int index) async{
    _cart[index].quantity++;
    _totalPrice.value += _cart[index].price;
    updateProduct(_cart[index]);
    update();
  }

  Future decreaseQuantity(int index) async{
    _cart[index].quantity--;
    _totalPrice.value -= _cart[index].price;
    if(_cart[index].quantity == 0)
      removeProduct(index);
    else
      updateProduct(_cart[index]);
    update();
  }

  void calculatePrice() {
    _totalPrice.value = 0.0;
    cart.forEach((element) => _totalPrice.value += element.price * element.quantity);
    update();
  }

  addToCart(CartProductModel cartProductModel) async {
    bool found = _cart.any((element) => cartProductModel.productId == element.productId);
    if(found)
      Get.snackbar(cartProductModel.name!, "product already exist in cart");
    else {
      _cart.add(cartProductModel);
      await _dbHelper.insertProduct(cartProductModel);
      Get.back();
      Get.snackbar(cartProductModel.name!, "product added to cart");
    }
  }

  removeProduct(int index) async {
    await _dbHelper.deleteProduct(_cart[index].id!);
    _cart.removeAt(index);
  }

}