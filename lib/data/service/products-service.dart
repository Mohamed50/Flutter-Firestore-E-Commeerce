import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_example/data/model/user.dart';

class ProductService{

  CollectionReference _productsCollection = FirebaseFirestore.instance.collection("Products");


  Future<List<QueryDocumentSnapshot>> fetchProducts() async {
    var result = await _productsCollection.get();
    return result.docs;
  }

}