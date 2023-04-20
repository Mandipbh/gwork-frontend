import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/code_confirmation_screen.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:g_worker_app/sign_in/view/sign_in_sign_up_screen.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:provider/provider.dart';

class RecoverPasswordProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool getIsRecoverPhoneLoading() => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  var recoverPasswordPhoneController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  requestOtp(BuildContext context) {
    if (recoverPasswordPhoneController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .requestOtp(recoverPasswordPhoneController.text, context)
          .then((requestOtpResponse) {
        if (requestOtpResponse.success!) {
          print("AAAAA${requestOtpResponse.success}");
          setIsLoading(false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CodeConfirmationScreen(
                  comingFrom: 2,
                  phoneNumber: recoverPasswordPhoneController.text),
            ),
          );
          ProgressLoader(context,
              "${tr("success_message.otp_send")} \n+39 ${recoverPasswordPhoneController.text}");
          notifyListeners();
        } else {
          setIsLoading(false);
          notifyListeners();
        }
      });
    }
  }

  changePassword(token, BuildContext context) {
    if (newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (newPasswordController.text !=
        confirmNewPasswordController.text) {
      ErrorLoader(context, tr("error_message.pass_doNot_coincide"));
      notifyListeners();
    } else if (newPasswordController.text.length <= 7) {
      ErrorLoader(context, tr("error_message.try_with_new_pass"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .changePassword(token, newPasswordController.text, context)
          .then((changePasswordResponse) {
        print("TOKEN :: $token");
        if (changePasswordResponse.success!) {
          print("AAAAA${changePasswordResponse.success}");
          clearRecoverPasswordProvider(context);
          setIsLoading(false);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const SignInSignUpScreen(),
            ),
            (route) => true, //if you want to disable back feature set to false
          );
          ProgressLoader(context, tr("success_message.pass_updated"));
          notifyListeners();
        }
        notifyListeners();
      });
    }
  }

  clearRecoverPasswordProvider(BuildContext context) {
    recoverPasswordPhoneController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
    notifyListeners();
  }
}
