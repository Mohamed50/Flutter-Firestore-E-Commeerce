import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/config/const.dart';
import 'package:getx_example/utils/binding.dart';
import 'package:getx_example/view/auth/auth-handler.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      home: AuthHandler(),
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
    );
  }
}
