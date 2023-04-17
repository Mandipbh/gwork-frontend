class Validations {
  static bool isPasswordValid(String password) {
    return RegExp(
            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);
  }

  static bool isMobileNumberValid(String phone) {
    return phone.length == 10;
  }

  static bool isBankAccountNumber(String acNumber) {
    return acNumber.length == 27 && RegExp(r'^[A-Za-z]{2}').hasMatch(acNumber);
  }
}
