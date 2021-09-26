import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final Widget? icon;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const CustomFormField({Key? key, this.controller, this.hint, this.label, this.validator, this.onSaved, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: icon,
      ),
    );
  }
}
