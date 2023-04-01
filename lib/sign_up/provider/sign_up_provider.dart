import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/validation_items.dart';
import 'package:g_worker_app/province/province_model.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/code_confirmation_screen.dart';
import 'package:g_worker_app/sign_in/provider/sign_in_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../common/common_loader.dart';
import '../../server_connection/api_client.dart';
import '../../shared_preference_data.dart';

class SignUpProvider extends ChangeNotifier {
  // String? _phoneNo;
  // String? get phoneNo => _phoneNo;

  //GetUserType

  int? _userType = 0;
  int? get userType => _userType;
  var phoneController = TextEditingController();
  bool _isLoading = false;
  SharedPreferenceData preferenceData = SharedPreferenceData();
  ProviceModel? _proviceModel;
  ProviceModel? get proviceModel => _proviceModel;
  String? _selectedProvince;
  String? get selectedProvince => _selectedProvince;
  bool getIsLoading() => _isLoading;
  // getPhone(val) {
  //   _phoneNo = val;
  //   notifyListeners();
  // }

  getProvinceList(BuildContext context) {
    ApiClient().getProvinceList(context).then((value) {
      _proviceModel = value;
      _selectedProvince = _proviceModel!.provice.first;
      notifyListeners();
    });
  }

  updateProvinceValue(val) {
    _selectedProvince = val;
    notifyListeners();
  }

  updateUserType(int type) {
    _userType = type;
    notifyListeners();
  }

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  checkPhoneNo(BuildContext context) {
    setIsLoading(true);
    ApiClient()
        .checkMobileNumber(phoneController.text, context)
        .then((checkPhoneResponse) {
      if (checkPhoneResponse.success!) {
        setIsLoading(false);
        ApiClient()
            .getOtp(phoneController.text, context)
            .then((checkGetOtpResponse) {
          if (checkGetOtpResponse.success!) {
            ProgressLoader(context,
                "Phone Number Registered  And Get Otp SuccessFully ${checkGetOtpResponse.otp}");
            print("AA");
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CodeConfirmationScreen(
                      comingFrom: 1, phoneNumber: phoneController.text)),
            );
            notifyListeners();
          }
        });
        notifyListeners();
      }
    });
  }

  //register data

  // set password

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String? _password;
  String? get password => _password;

  setPassword(String password1, String confirmPassword, BuildContext context) {
    if (password1.isEmpty || confirmPassword.isEmpty) {
      ErrorLoader(context, "Password cannot be empty");
      notifyListeners();
    } else if (password1 != confirmPassword) {
      ErrorLoader(context, "Password do not match");
      notifyListeners();
    } else {
      _password = confirmPassword;
      print("password ==> $_password");
      notifyListeners();
      return true;
    }
  }

  String? _name;
  String? get name => _name;
  String? _lastName;
  String? get lastName => _lastName;
  String? _email;
  String? get email => _email;
  String? _textCode;
  String? get textCode => _textCode;
  String? _birthDate;
  String? get birthDate => _birthDate;

  var nameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var textCodeController = TextEditingController();
  var birthDateController = TextEditingController();

  setPersonalInfo(String name, String lastName, String email, String textCode,
      String birthDate, BuildContext context) {
    if (name.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        textCode.isEmpty ||
        birthDate.isEmpty) {
      ErrorLoader(context, "Please fill all the details");
      notifyListeners();
    } else {
      _name = name;
      _lastName = lastName;
      _email = email;
      _textCode = textCode;
      _birthDate = birthDate;
      notifyListeners();
      return true;
    }
  }

  // payment Method

  String? _cardHolder;
  String? get cardHolder => _cardHolder;
  String? _cardNumber;
  String? get cardNumber => _cardNumber;
  String? _expireDate;
  String? get expireDate => _expireDate;
  String? _cvv;
  String? get cvv => _cvv;

  var cardHolderController = TextEditingController();
  var cardNumberController = TextEditingController();
  var expireDateController = TextEditingController();
  var cvvController = TextEditingController();
  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    // The month has passed if:
    // 1. The year is in the past. In that case, we just assume that the month
    // has passed
    // 2. Card's month (plus another month) is more than current month.
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    // The year has passed if the year we are currently is more than card's
    // year
    return fourDigitsYear < now.year;
  }

  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  setPaymentMethod(String cardHolder, String cardNumber, String expireDate,
      String cvv, BuildContext context) {
    int? year;
    int? month;

    if (cardHolder.isEmpty ||
        cardNumber.isEmpty ||
        expireDate.isEmpty ||
        cvv.isEmpty) {
      ErrorLoader(context, "Please fill all the details");
      notifyListeners();
      return false;
    }
    // else if (expireDate.contains(RegExp(r'(/)'))) {
    //   var split = expireDate.split(RegExp(r'(/)'));
    //
    //   month = int.parse(split[0]);
    //   year = int.parse(split[1]);
    //   notifyListeners();
    //   return false;
    // } else if ((month! < 1) || (month > 12)) {
    //   ErrorLoader(context, "Expiry month is invalid");
    //   notifyListeners();
    //   return false;
    // } else if ((convertYearTo4Digits(year!) < 1) ||
    //     (convertYearTo4Digits(year!) > 2099)) {
    //   // We are assuming a valid should be between 1 and 2099.
    //   // Note that, it's valid doesn't mean that it has not expired.
    //   ErrorLoader(context, "Expiry year is invalid'");
    //   notifyListeners();
    //   return false;
    // } else if (!hasDateExpired(month, year)) {
    //   ErrorLoader(context, "Card has expired");
    //   notifyListeners();
    //   return false;
    // }
    else {
      _cardHolder = cardHolder;
      _cardNumber = cardNumber;
      _expireDate = expireDate;
      _cvv = cvv;
      notifyListeners();
      return true;
    }
  }

  clearSignUpProvider(BuildContext context) {
    phoneController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nameController.clear();
    lastNameController.clear();
    textCodeController.clear();
    emailController.clear();
    birthDateController.clear();
    cardHolderController.clear();
    cardNumberController.clear();
    expireDateController.clear();
    cvvController.clear();
    Provider.of<ProfilePicProvider>(context, listen: false).clearImage();
    notifyListeners();
  }
}
