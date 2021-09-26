import 'package:get/get.dart';
import 'package:getx_example/data/model/product.dart';
import 'package:getx_example/data/service/products-service.dart';

class HomeViewModel extends GetxController{

  RxList<ProductModel> _products = <ProductModel>[].obs;
  List<ProductModel> get products => _products.value;

  HomeViewModel(){
    fetchProducts();
  }

  fetchProducts(){
    ProductService().fetchProducts().then((docs){
      docs.forEach((element) {
        _products.add(ProductModel.fromMap(element.data() as Map));
      });
      update();
    });
  }


}