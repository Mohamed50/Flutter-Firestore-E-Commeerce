import 'package:get/get.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view-model/home-view-model.dart';
import 'package:getx_example/view-model/menu-view-model.dart';

class Binding extends Bindings{

  @override
  void dependencies() {
    Get.lazyPut(() => AuthViewModel());
    Get.lazyPut(() => MenuViewModel());
    Get.lazyPut(() => HomeViewModel());
  }



}