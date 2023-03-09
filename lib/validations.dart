class Validations{
  static bool isPasswordValid(String password){
    return RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(password);
  }
  static bool isMobileNumberValid(String phone){
    return phone.length == 10;
  }
}
