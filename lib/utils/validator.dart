import 'package:get/get.dart';

const String emailEmptyMessageKey = 'emailEmptyMessage';
const String emailNotValidMessageKey = 'emailNotValidMessage';
const String passwordEmptyMessageKey = 'passwordEmptyMessage';
const String passwordNotValidMessageKey = 'passwordNotValidMessage';
const String nameEmptyMessageKey = 'nameEmptyMessage';


class InputsValidator{

  static RegExp _emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp _passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');


  static String? emailValidator(String? value){
    if(value == null || value.isEmpty)
      return emailEmptyMessageKey.tr;
    else if(!_emailRegExp.hasMatch(value))
      return emailNotValidMessageKey.tr;
    else
      return null;
  }

  static String? passwordValidator(String? value){
    if(value == null || value.isEmpty)
      return passwordEmptyMessageKey.tr;
    else if(!_passwordRegExp.hasMatch(value))
      return passwordNotValidMessageKey.tr;
    else
      return null;
  }

  static String? nameValidator(String? value){
    if(value == null || value.isEmpty)
      return nameEmptyMessageKey.tr;
    else
      return null;
  }


}