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
  bool _isLogging = false;
  SharedPreferenceData preferenceData = SharedPreferenceData();
  ProviceModel? _proviceModel;
  ProviceModel? get proviceModel => _proviceModel;
  String? _selectedProvince;
  String? get selectedProvince => _selectedProvince;
  bool getIsLogging() => _isLogging;
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

  setIsLogging(bool value) {
    _isLogging = value;
    notifyListeners();
  }

  checkPhoneNo(BuildContext context) {
    setIsLogging(true);
    ApiClient()
        .checkMobileNumber(phoneController.text, context)
        .then((checkPhoneResponse) {
      if (checkPhoneResponse.success!) {
        setIsLogging(false);
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

  setPaymentMethod(String cardHolder, String cardNumber, String expireDate,
      String cvv, BuildContext context) {
    if (cardHolder.isEmpty ||
        cardNumber.isEmpty ||
        expireDate.isEmpty ||
        cvv.isEmpty) {
      ErrorLoader(context, "Please fill all the details");
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
