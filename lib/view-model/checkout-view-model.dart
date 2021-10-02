import 'package:get/get.dart';
import 'package:getx_example/data/model/order.dart';
import 'package:getx_example/data/service/order-service.dart';
import 'package:getx_example/view-model/cart-view-model.dart';
import 'package:getx_example/view-model/order-view-model.dart';
import 'package:getx_example/view/widgets/loading-dialog.dart';
import 'auth-view-model.dart';

class CheckoutViewModel extends GetxController {
  OrderModel orderModel = OrderModel(address: Address());

  addOrder() async {
    CartViewModel cartViewModel = Get.find<CartViewModel>();
    Get.defaultDialog(title: "", content: LoadingDialog(), barrierDismissible: false);
    String userId = Get.find<AuthViewModel>().user!.uid;
    orderModel.user = userId;
    orderModel.products = cartViewModel.getOrderProducts();
    orderModel.total = cartViewModel.totalPrice;
    print(orderModel.toJson());
    await OrderService().addOrder(orderModel);
    cartViewModel.clear();
    Get.back();
    Get.find<OrdersViewModel>().fetchOrders();
  }
}
