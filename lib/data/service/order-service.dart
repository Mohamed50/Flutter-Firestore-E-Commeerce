import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:getx_example/data/model/order.dart';

class OrderService{

  CollectionReference _ordersCollection = FirebaseFirestore.instance.collection("Orders");


  Future<List<QueryDocumentSnapshot>> fetchUserOrders(String userId) async {
    print("Users/$userId");
    var result = await _ordersCollection.where('user', isEqualTo: "$userId").get();
    return result.docs;
  }

  Future<DocumentSnapshot> fetchOrderById(String id) async {
    var result = await _ordersCollection.doc(id).get();
    return result;
  }

  addOrder(OrderModel orderModel) async {
      await _ordersCollection.add(orderModel.toJson());
  }

}