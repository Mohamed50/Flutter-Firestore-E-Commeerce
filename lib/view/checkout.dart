import 'package:flutter/material.dart';
import 'package:getx_example/config/const.dart';
import 'package:getx_example/view-model/checkout-view-model.dart';
import 'package:getx_example/view/widgets/customs/custom-button.dart';
import 'package:getx_example/view/widgets/customs/custom-form-field.dart';
import 'widgets/customs/custom-text.dart';

class CheckoutPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final CheckoutViewModel checkoutViewModel = CheckoutViewModel();

  CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade50,
        title: CustomText(
          "Checkout",
          color: primaryColor,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              CustomFormField(
                label: "Country",
                onSaved: (newValue) =>
                    checkoutViewModel.orderModel.address!.country = newValue,
                validator: (value) => value != null && value.isEmpty
                    ? "Please enter country"
                    : null,
              ),
              SizedBox(height: 8.0),
              CustomFormField(
                label: "State",
                onSaved: (newValue) =>
                    checkoutViewModel.orderModel.address!.state = newValue,
                validator: (value) => value != null && value.isEmpty
                    ? "Please enter state"
                    : null,
              ),
              SizedBox(height: 8.0),
              CustomFormField(
                label: "City",
                onSaved: (newValue) =>
                    checkoutViewModel.orderModel.address!.city = newValue,
                validator: (value) =>
                    value != null && value.isEmpty ? "Please enter cty" : null,
              ),
              SizedBox(height: 8.0),
              CustomFormField(
                label: "Street",
                onSaved: (newValue) =>
                    checkoutViewModel.orderModel.address!.street = newValue,
                validator: (value) => value != null && value.isEmpty
                    ? "Please enter street"
                    : null,
              ),
              SizedBox(height: 64.0),
              CustomButton(
                text: "Confirm",
                padding: EdgeInsets.all(16.0),
                onPressed: () {
                  print("confirm button");
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    checkoutViewModel.addOrder();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
