import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/validation_items.dart';
import 'package:g_worker_app/province/province_model.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/code_confirmation_screen.dart';
import 'package:g_worker_app/sign_in/provider/sign_in_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/profile_picture_view/image_provider/image_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/document_provider/document_provider.dart';
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
    if (phoneController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (phoneController.text.length < 10) {
      ErrorLoader(context, tr("error_message.valid_phone"));
      notifyListeners();
    } else {
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
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CodeConfirmationScreen(
                        comingFrom: 1, phoneNumber: phoneController.text)),
              );
              ProgressLoader(context,
                  "${tr("success_message.otp_send")} \n+39 ${phoneController.text}");
              notifyListeners();
            }
          });
          notifyListeners();
        }
      });
    }
  }

  //register data

  // set password

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String? _password;
  String? get password => _password;

  setPassword(String password1, String confirmPassword, BuildContext context) {
    if (password1.isEmpty || confirmPassword.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (password1 != confirmPassword) {
      ErrorLoader(context, tr("error_message.pass_doNot_coincide"));
      notifyListeners();
    } else if (password1.length <= 7) {
      ErrorLoader(context, tr("error_message.try_with_new_pass"));
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
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (name.length < 3) {
      ErrorLoader(context, tr("error_message.valid_name"));
      notifyListeners();
    } else if (lastName.length < 3) {
      ErrorLoader(context, tr("error_message.valid_last_name"));
      notifyListeners();
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email)) {
      ErrorLoader(context, tr("error_message.valid_email"));
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
    if (cardHolder.isEmpty ||
        cardNumber.isEmpty ||
        expireDate.isEmpty ||
        cvv.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
      return false;
    }
    if (int.parse(expireDate.split("/")[0]) > 12) {
      ErrorLoader(context, tr("error_message.expire_month"));
      notifyListeners();
      return false;
    } else if (cardHolder.length < 3) {
      ErrorLoader(context, tr("error_message.valid_card_holder"));
      notifyListeners();
    } else if (cardNumber.length < 16) {
      ErrorLoader(context, tr("error_message.valid_card_holder"));
      notifyListeners();
    } else {
      _cardHolder = cardHolder;
      _cardNumber = cardNumber;
      _expireDate = expireDate;
      _cvv = cvv;
      notifyListeners();
      return true;
    }
  }

  String? _bankAccountNumber;
  String? get bankAccountNumber => _bankAccountNumber;

  var bankAccountController = TextEditingController();

  setBankDetail(String bankAccountNumber, BuildContext context) {
    if (bankAccountNumber.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
      return false;
    } else {
      _bankAccountNumber = bankAccountNumber;
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
    bankAccountController.clear();
    Provider.of<ProfilePicProvider>(context, listen: false).clearImage();
    Provider.of<DocumentPicProvider>(context, listen: false).clearDocument();
    notifyListeners();
  }
}
