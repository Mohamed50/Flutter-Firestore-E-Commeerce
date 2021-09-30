import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/config/const.dart';
import 'package:getx_example/utils/binding.dart';
import 'package:getx_example/view/auth/auth-handler.dart';
import 'view-model/cart-view-model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartViewModel());
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      home: AuthHandler(),
      theme: ThemeData(
          primaryColor: primaryColor,
          fontFamily: "Montserrat",
          appBarTheme: AppBarTheme(
              color: Colors.grey.shade50,
              titleTextStyle: TextStyle(color: primaryColor),
              iconTheme: IconThemeData(color: primaryColor))),
    );
  }
}
