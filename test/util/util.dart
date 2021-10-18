import 'package:flutter/material.dart';
import 'package:get/get.dart';

makeWidgetTestable(Widget child){
  return GetMaterialApp(
    home: child,
  );
}