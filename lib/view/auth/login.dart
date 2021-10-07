import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_example/config/const.dart';
import 'package:getx_example/utils/validator.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view/auth/custom-auth-page.dart';
import 'package:getx_example/view/auth/register.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';
import 'package:getx_example/view/widgets/customs/custom-form-field.dart';
import 'package:getx_example/view/widgets/customs/custom-social-icon.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';
import 'package:getx_example/view/widgets/customs/text-divider.dart';

class LoginPage extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomAuthPage(
        headerPadding: const EdgeInsets.all(24.0),
        header: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
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
                  "Welcome,",
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                SizedBox(height: 8.0),
                CustomText(
                  "sign in to continue",
                  color: Colors.white,
                  fontSize: 28.0,
                ),
              ],
            ),
            InkWell(
              onTap: () => Get.to(() => RegisterPage()),
              child: CustomText(
                "Sign up",
                color: primaryColor,
                fontSize: 18.0,
              ),
            )
          ],
        ),
        bodyPadding: const EdgeInsets.all(24.0),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormField(
                icon: Icon(Icons.mail),
                label: "Email",
                hint: "example@gmail.com",
                onSaved: (value) => controller.email = value,
                validator: InputsValidator.emailValidator,
              ),
              CustomFormField(
                icon: Icon(Icons.lock),
                label: "Password",
                hint: "********",
                onSaved: (value) => controller.password = value,
                validator: InputsValidator.passwordValidator,
              ),
              SizedBox(height: 32.0),
              CustomButton(
                text: "Sign in",
                padding: EdgeInsets.all(16.0),
                onPressed: () {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate())
                    controller.emailSignIn();
                },
              ),
              TextDivider(
                "OR",
                height: 64.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconButton(
                    color: Color(0xFF4267B2),
                    iconData: FontAwesomeIcons.facebookF,
                    padding: EdgeInsets.all(12.0),
                    onPressed: controller.facebookSignIn,
                  ),
                  SizedBox(width: 32.0),
                  CustomIconButton(
                    color: Color(0xFFdb3236),
                    iconData: FontAwesomeIcons.google,
                    padding: EdgeInsets.all(12.0),
                    onPressed: controller.googleSignIn,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
