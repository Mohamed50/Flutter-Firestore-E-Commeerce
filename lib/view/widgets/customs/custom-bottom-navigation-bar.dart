import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_example/config/const.dart';
import 'package:getx_example/view-model/menu-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CustomBottomNavigationBar extends GetWidget<MenuViewModel> {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SalomonBottomBar(
        currentIndex: controller.bottomNavigationIndex,
        onTap: controller.onBottomNavigationIndexChanged,
        selectedItemColor: primaryColor,
        items: [
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.home),
            title: CustomText("Home"),
          ),
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.search),
            title: CustomText("Search"),
          ),
          SalomonBottomBarItem(
            icon: Icon(FontAwesomeIcons.user),
            title: CustomText("Profile"),
          ),
        ],
      ),
    );
  }
}
