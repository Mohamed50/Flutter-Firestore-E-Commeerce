import 'package:flutter_test/flutter_test.dart';
import 'package:getx_example/utils/validator.dart';
import 'package:get/get.dart';

import '../util/const.dart';

main() {


  group(
    "Email validator test",
    () {
      test(
        'Given email input when input is null then return ${emailEmptyMessageKey.tr}',
        () {
          // Assign
          String? value;
          // ACT
          String? result = InputsValidator.emailValidator(value);
          // Assert
          expect(result, emailEmptyMessageKey.tr);
        },
      );

      test(
        'Given email input when input is empty then return ${emailEmptyMessageKey.tr}',
        () {
          // Assign
          String? value = '';
          // ACT
          String? result = InputsValidator.emailValidator(value);
          // Assert
          expect(result, emailEmptyMessageKey.tr);
        },
      );

      test(
        'Given email input when input is not valid email then return ${emailNotValidMessageKey.tr}',
        () {
          // Assign
          String? value = unValidEmail;
          // ACT
          String? result = InputsValidator.emailValidator(value);
          // Assert
          expect(result, emailNotValidMessageKey.tr);
        },
      );

      test(
        'Given email input when input is valid email then return null',
        () {
          // Assign
          String? value = validEmail;
          // ACT
          String? result = InputsValidator.emailValidator(value);
          // Assert
          expect(result, null);
        },
      );
    },
  );

  group(
    "password validator test",
    () {
      test(
        'Given password input when input is null then return ${passwordEmptyMessageKey.tr}',
        () {
          // Assign
          String? value;
          // ACT
          String? result = InputsValidator.passwordValidator(value);
          // Assert
          expect(result, passwordEmptyMessageKey.tr);
        },
      );

      test(
        'Given password input when input is empty then return ${passwordEmptyMessageKey.tr}',
        () {
          // Assign
          String? value = '';
          // ACT
          String? result = InputsValidator.passwordValidator(value);
          // Assert
          expect(result, passwordEmptyMessageKey.tr);
        },
      );

      test(
        'Given password input when input is not valid password then return ${passwordNotValidMessageKey.tr}',
        () {
          // Assign
          String? value = unValidPassword;
          // ACT
          String? result = InputsValidator.passwordValidator(value);
          // Assert
          expect(result, passwordNotValidMessageKey.tr);
        },
      );

      test(
        'Given password input when input is valid password then return null',
        () {
          // Assign
          String? value = validPassword;
          // ACT
          String? result = InputsValidator.passwordValidator(value);
          // Assert
          expect(result, null);
        },
      );
    },
  );

  group(
    'name validator tests',
    () {
      test(
        'Given name input when input is null then return ${nameEmptyMessageKey.tr}',
        () {
          // Assign
          String? value;
          // ACT
          String? result = InputsValidator.nameValidator(value);
          // Assert
          expect(result, nameEmptyMessageKey.tr);
        },
      );

      test(
        'Given name input when input is empty then return ${nameEmptyMessageKey.tr}',
        () {
          // Assign
          String? value = '';
          // ACT
          String? result = InputsValidator.nameValidator(value);
          // Assert
          expect(result, nameEmptyMessageKey.tr);
        },
      );

      test(
        'Given name input when input is not empty then return null',
        () {
          // Assign
          String? value = 'mohamed';
          // ACT
          String? result = InputsValidator.nameValidator(value);
          // Assert
          expect(result, null);
        },
      );
    },
  );


}
