import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class ProfilePage extends GetWidget<AuthViewModel> {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            controller.user!.displayName != null
                ? CircleAvatar(
                    radius: 32.0,
                    backgroundImage: NetworkImage(controller.user!.photoURL!),
                  )
                : Container(),
            SizedBox(height: 16.0),
            CustomText(controller.user!.displayName!),
            SizedBox(height: 16.0),
            CustomText(controller.user!.email!),
            CustomButton(
              width: MediaQuery.of(context).size.width * 1/2,
              padding: EdgeInsets.all(12.0),
              text: "Log out",
              onPressed: controller.signOut,
            ),
          ],
        ),
      ),
    );
  }
}
