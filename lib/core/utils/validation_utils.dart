bool isValidEmail(String value) {
  RegExp regExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regExp.hasMatch(value);
}

bool isValidName(String name) {
  RegExp nameExp = RegExp(r'^[a-zA-Z\s]{2,15}$');
  return nameExp.hasMatch(name);
}

bool isValidPhoneNumber(String num) {
  RegExp numExp = RegExp(r'^^(?:[+0]9)?[0-9]{5,10}$');
  return numExp.hasMatch(num);
}

bool isValidPassword(String password) {
  RegExp passExp =
      RegExp(r'^(?=.*[^a-zA-Z\d\s])(?=.*[a-zA-Z])[@$!%*?&a-zA-Z\d]{8,}$');
  return passExp.hasMatch(password);
}
