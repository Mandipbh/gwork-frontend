import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/validation_items.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/code_confirmation_screen.dart';
import 'package:g_worker_app/sign_in/provider/sign_in_provider.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../../common/common_loader.dart';
import '../../server_connection/api_client.dart';
import '../../shared_preference_data.dart';

class SignUpProvider extends ChangeNotifier {
  String? _phoneNo;
  String? get phoneNo => _phoneNo;
  var phoneController = TextEditingController();
  bool _isLogging = false;
  SharedPreferenceData preferenceData = SharedPreferenceData();

  getPhone(val) {
    _phoneNo = val;
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
        ProgressLoader(
            context, "Phone Number Registered  And Get Otp SuccessFully");
        setIsLogging(false);
        ApiClient()
            .getOtp(phoneController.text, context)
            .then((checkGetOtpResponse) {
          if (checkGetOtpResponse.success!) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CodeConfirmationScreen(
                      phoneNumber: phoneController.text)),
            );
          }
        });
      }
    });
  }

  //register data

  // set password

  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  String? _password;
  String? get password => _password;

  setPassword(String password1, String confirmPassword) {
    print("password1 ==> $password1");
    print("confpassword1 ==> $confirmPassword");
    if (password1 == confirmPassword) {
      _password = confirmPassword;
      print("password ==> $_password");
      notifyListeners();
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
      String birthDate) {
    _name = name;
    _lastName = lastName;
    _email = email;
    _textCode = textCode;
    _birthDate = birthDate;
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

  setPaymentMethod(cardHolder, cardNumber, expireDate, cvv) {
    _cardHolder = cardHolder;
    _cardNumber = cardNumber;
    _expireDate = expireDate;
    _cvv = cvv;
  }
}
