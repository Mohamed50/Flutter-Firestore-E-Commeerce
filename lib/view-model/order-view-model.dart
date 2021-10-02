import 'package:get/get.dart';
import 'package:getx_example/data/model/order.dart';
import 'package:getx_example/data/service/order-service.dart';
import 'package:getx_example/view-model/auth-view-model.dart';

class OrdersViewModel extends GetxController{

  RxList<OrderModel> _orders = <OrderModel>[].obs;
  List<OrderModel> get orders => _orders.value;

  OrdersViewModel(){
    fetchOrders();
  }

  fetchOrders(){
    String userId = Get.find<AuthViewModel>().user!.uid;
    OrderService().fetchUserOrders(userId).then((docs){
      docs.forEach((element) async {
        Map<String, dynamic> map = element.data() as Map<String, dynamic>;
        print(map);
        List temp = map["products"];
        for(int i = 0; i < temp.length; i++) {
          var value = await temp[i]["product"].get();
          temp[i]["product"] = value.data();
        }
        map["products"] = temp;
        _orders.add(OrderModel.fromJson(map));
        // print(json.encode(map));
        // _products.add(ProductModel.fromMap((element.data() as Map)..putIfAbsent("id", () => element.id)));
      });
      update();
    });
  }


}