import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view/auth/login.dart';
import 'package:getx_example/view/menu/menu.dart';

import '../menu/home.dart';

class AuthHandler extends GetWidget<AuthViewModel> {
  const AuthHandler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
        () => Get.find<AuthViewModel>().user != null ? MenuPage() : LoginPage()
    );
  }
}
