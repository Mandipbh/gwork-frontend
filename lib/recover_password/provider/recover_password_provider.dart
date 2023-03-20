import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/code_confirmation_screen.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:g_worker_app/sign_in/view/sign_in_sign_up_screen.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

class RecoverPasswordProvider extends ChangeNotifier {
  bool _isLogging = false;

  bool getIsLogging() => _isLogging;

  setIsLogging(bool value) {
    _isLogging = value;
    notifyListeners();
  }

  var recoverPasswordPhoneController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  requestOtp(BuildContext context) {
    if (recoverPasswordPhoneController.text.isEmpty) {
      ErrorLoader(context, "PhoneNumber cannot be empty");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .requestOtp(recoverPasswordPhoneController.text, context)
          .then((requestOtpResponse) {
        if (requestOtpResponse.success!) {
          print("AAAAA${requestOtpResponse.success}");
          setIsLogging(false);
          ProgressLoader(context,
              "Phone Number Registered  And Request Otp SuccessFully ${requestOtpResponse.otp}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CodeConfirmationScreen(
                  isRegister: false,
                  phoneNumber: recoverPasswordPhoneController.text),
            ),
          );
          notifyListeners();
        }
      });
    }
  }

  changePassword(token, context) {
    if (newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      ErrorLoader(context, "Password cannot be empty");
      notifyListeners();
    } else if (newPasswordController.text !=
        confirmNewPasswordController.text) {
      ErrorLoader(context, "Password do not match");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .changePassword(newPasswordController.text, token, context)
          .then((changePasswordResponse) {
        print("TOKEN :: $token");
        if (changePasswordResponse.success!) {
          print("AAAAA${changePasswordResponse.success}");
          setIsLogging(false);
          ProgressLoader(context, "Password Change SuccessFully");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const SignInSignUpScreen(),
            ),
            (route) => false, //if you want to disable back feature set to false
          );
          notifyListeners();
        }
      });
    }
  }
}
