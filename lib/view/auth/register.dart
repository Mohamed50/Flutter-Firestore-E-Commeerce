import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_example/view-model/auth-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';
import 'package:getx_example/view/widgets/customs/custom-form-field.dart';
import 'package:getx_example/view/widgets/customs/custom-text.dart';

class RegisterPage extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RegisterPage({Key? key}) : super(key: key);

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
              CustomText(
                "Sign up,",
                fontSize: 32,
              ),
              SizedBox(height: 8.0),
              CustomText(
                "Sign up to create new user",
                color: Colors.grey[800]?.withOpacity(0.7),
                fontSize: 14.0,
              ),
              SizedBox(height: 32.0),
              CustomFormField(
                icon: Icon(Icons.person),
                label: "Name",
                hint: "John Doe",
                onSaved: (value) => controller.name = value,
                validator: (value) => value != null ? null : "enter valid name",
              ),
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
                text: "Sign Up",
                padding: EdgeInsets.all(16.0),
                onPressed: () {
                  _formKey.currentState!.save();
                  if(_formKey.currentState!.validate())
                    controller.emailSignUp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
