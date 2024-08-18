import 'package:shop_app/core/utils/validation_utils.dart';

String? nameValidator(String? value, {required String message}) {
  if (value!.isNotEmpty) {
    if (!isValidName(value)) {
      return 'Invalid name';
    }
    return null;
  } else {
    return 'Enter your name';
  }
}

String? emailValidator(String? value) {
  if (value!.isNotEmpty) {
    if (!isValidEmail(value)) {
      return 'Invalid email';
    }
    return null;
  } else {
    return 'Enter your email';
  }
}

String? phoneNumberValidator(String? value) {
  if (value!.isNotEmpty) {
    if (!isValidPhoneNumber(value)) {
      return 'Invalid phone number';
    }
    return null;
  } else {
    return 'Enter your phone number';
  }
}

String? passwordValidator(String? value, {required String message}) {
  if (value!.isNotEmpty) {
    if (value.length < 3) {
      return 'Password must have UpperCase and LowerCase letter and +8';
    }
    return null;
  } else {
    return message;
  }
}

String? confirmPasswordValidator(
  String? value, {
  required String password,
}) {
  if (value!.isNotEmpty) {
    if (value != password) {
      return "Password does'nt match";
    }
    return null;
  } else {
    return 'Enter your password';
  }
}

String? searchValidator(String? value) {
  if (value!.isNotEmpty) {
    return null;
  } else {
    return 'Search field can\'t be empty !';
  }
}
