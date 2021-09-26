import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:getx_example/config/const.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    "Welcome,",
                    fontSize: 32,
                  ),
                  InkWell(
                    onTap: () => Get.to(()=> RegisterPage()),
                    child: CustomText(
                      "Sign up",
                      color: primaryColor,
                      fontSize: 18.0,
                    ),
                  )
                ],
              ),
              SizedBox(height: 8.0),
              CustomText(
                "Sign in to continue",
                color: Colors.grey[800]?.withOpacity(0.7),
                fontSize: 14.0,
              ),
              SizedBox(height: 32.0),
              CustomFormField(
                icon: Icon(Icons.mail),
                label: "Email",
                hint: "example@gmail.com",
                onSaved: (value) => controller.email = value,
                validator: (value) => value != null ? null : "enter valid email",
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
                text: "Sign in",
                padding: EdgeInsets.all(16.0),
                onPressed: () {
                  _formKey.currentState!.save();
                  if(_formKey.currentState!.validate())
                    controller.emailSignIn();
                },
              ),
              TextDivider(
                "OR",
                height: 64.0,
              ),
              CustomIconButton(
                color: Color(0xFF4267B2),
                iconData: FontAwesomeIcons.facebookF,
                text: "Continue using facebook",
                padding: EdgeInsets.all(12.0),
                onPressed: controller.facebookSignIn,
              ),
              SizedBox(height: 16.0),
              CustomIconButton(
                color: Color(0xFFdb3236),
                iconData: FontAwesomeIcons.google,
                text: "Continue using google",
                padding: EdgeInsets.all(12.0),
                onPressed: controller.googleSignIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
