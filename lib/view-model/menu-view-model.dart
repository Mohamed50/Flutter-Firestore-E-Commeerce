import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuViewModel extends GetxController{

  var _bottomNavigationIndex = 0.obs;
  int get bottomNavigationIndex => _bottomNavigationIndex.value;

  PageController _controller = PageController();
  PageController get controller => _controller;

  void onBottomNavigationIndexChanged(int index){
    _bottomNavigationIndex.value = index;
    controller.jumpToPage(index);
    update();
  }


  void onPageChanged(int index) {
    _bottomNavigationIndex.value = index;
    update();
  }


}