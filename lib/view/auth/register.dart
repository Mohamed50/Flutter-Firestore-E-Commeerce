import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';
import 'package:getx_example/view/widgets/customs/custom-form-field.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

import 'custom-auth-page.dart';

class RegisterPage extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAuthPage(
        headerPadding: EdgeInsets.fromLTRB(
            24.0, MediaQuery.of(context).padding.top + 8.0, 24.0, 24.0),
        header: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_back_ios_rounded,
                    color: Colors.white,
                  ),
                  CustomText(
                    "back",
                    fontSize: 18.0,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 64,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  SizedBox(height: 24.0),
                  CustomText(
                    "Register,",
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  SizedBox(height: 8.0),
                  CustomText(
                    "create new account",
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        bodyPadding:
            const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        body: Container(
          height: MediaQuery.of(context).size.height * 3 / 5,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormField(
                  icon: Icon(Icons.person),
                  label: "Name",
                  hint: "John Doe",
                  onSaved: (value) => controller.name = value,
                  validator: (value) =>
                      value != null ? null : "enter valid name",
                ),
                CustomFormField(
                  icon: Icon(Icons.mail),
                  label: "Email",
                  hint: "example@gmail.com",
                  onSaved: (value) => controller.email = value,
                  validator: (value) =>
                      value != null ? null : "enter valid email",
                ),
                CustomFormField(
                  icon: Icon(Icons.lock),
                  label: "Password",
                  hint: "********",
                  onSaved: (value) => controller.password = value,
                  validator: (value) => value != null ? null : "enter password",
                ),
                SizedBox(height: 32.0),
                CustomButton(
                  text: "Sign Up",
                  padding: EdgeInsets.all(16.0),
                  onPressed: () {
                    _formKey.currentState!.save();
                    if (_formKey.currentState!.validate())
                      controller.emailSignUp();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
