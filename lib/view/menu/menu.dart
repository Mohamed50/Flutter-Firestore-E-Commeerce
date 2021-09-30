import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/menu-view-model.dart';
import 'package:getx_example/view/cart.dart';
import 'package:getx_example/view/menu/home.dart';
import 'package:getx_example/view/menu/profile.dart';
import 'package:getx_example/view/menu/search.dart';
import 'package:getx_example/view/widgets/customs/custom-bottom-navigation-bar.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class MenuPage extends GetWidget<MenuViewModel> {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        title: CustomText("E - Commerce"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(FontAwesomeIcons.search)),
          IconButton(onPressed: (){
            Get.to(CartPage());
          }, icon: Icon(FontAwesomeIcons.shoppingCart)),
        ],
      ),
      drawer: Drawer(),
      body: PageView(
          controller: controller.controller,
          onPageChanged: controller.onPageChanged,
          children: [
            HomePage(),
            SearchPage(),
            ProfilePage(),
          ],
        ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
