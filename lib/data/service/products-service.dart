import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService{

  CollectionReference _productsCollection = FirebaseFirestore.instance.collection("Products");


  Future<List<QueryDocumentSnapshot>> fetchProducts() async {
    var result = await _productsCollection.get();
    return result.docs;
  }

  Future<DocumentSnapshot> fetchProductById(String id) async {
    var result = await _productsCollection.doc(id).get();
    return result;
  }

}