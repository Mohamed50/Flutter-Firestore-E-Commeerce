import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';

class ProfilePage extends GetWidget<AuthViewModel> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: CustomButton(
          text: "Log out",
          onPressed: controller.signOut,
        ),
      ),
    );
  }
}
