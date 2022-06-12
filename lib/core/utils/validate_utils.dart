class ValidateUtils {
  String password =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  String phone = r'(^(?:[+0]9)?[0-9]{10,12}$)';
  String email = r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
      r"{0,253}[a-zA-Z0-9])?)*$";
  bool checkRegex(String pattern, String? value) {
    RegExp regex = RegExp(pattern);
    if (value!.isEmpty || !regex.hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}
