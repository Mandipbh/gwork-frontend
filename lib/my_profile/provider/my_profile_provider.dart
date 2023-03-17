import 'package:flutter/cupertino.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/my_profile/model/get_profile_response.dart';

import '../../server_connection/api_client.dart';

class MyProfileProvider extends ChangeNotifier {
  GetProfileModel? _model;
  GetProfileModel? get model => _model;
  bool _isLogging = false;
  bool getIsLogging() => _isLogging;

  setIsLogging(bool value) {
    _isLogging = value;
    notifyListeners();
  }

  getUserProfile(BuildContext context) async {
    _model = await ApiClient().getProfile(context);

    if (_model != null) {
      _model!.user!.name!;
      _model!.user!.surname!;
      _model!.user!.email!;
      _model!.user!.birthDate!;
    }
    notifyListeners();
  }

  clearProfileProvider() {
    _model = null;
    notifyListeners();
  }

  updateName(nameController, BuildContext context) {
    if (nameController.text.isEmpty) {
      ErrorLoader(context, "Name Can Not Be Empty");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .updateName(nameController.text, context)
          .then((updateNameSuccessResponse) {
        if (updateNameSuccessResponse.success!) {
          setIsLogging(false);
          _model!.user!.name = nameController.text;
          print("!!${_model!.user!.name}");
          ProgressLoader(context, "your Name Update SuccessFully");
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateLastName(lastNameController, BuildContext context) {
    if (lastNameController.text.isEmpty) {
      ErrorLoader(context, "LastName Can Not Be Empty");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .updateLastName(lastNameController.text, context)
          .then((updateLastNameSuccessResponse) {
        if (updateLastNameSuccessResponse.success!) {
          setIsLogging(false);
          _model!.user!.surname = lastNameController.text;
          print("!!${_model!.user!.surname}");
          ProgressLoader(context, "your LastName Update SuccessFully");
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateEmail(emailController, BuildContext context) {
    if (emailController.text.isEmpty) {
      ErrorLoader(context, "Email Can Not Be Empty");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .updateEmail(emailController.text, context)
          .then((updateEmailSuccessResponse) {
        if (updateEmailSuccessResponse.success!) {
          setIsLogging(false);
          _model!.user!.email = emailController.text;
          print("!!${_model!.user!.email}");
          ProgressLoader(context, "your Email Update SuccessFully");
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateBirthDate(birthDateController, BuildContext context) {
    if (birthDateController.text.isEmpty) {
      ErrorLoader(context, "Birthdate Can Not Be Empty");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .updateBirthDate(birthDateController.text, context)
          .then((updateEmailSuccessResponse) {
        if (updateEmailSuccessResponse.success!) {
          setIsLogging(false);
          _model!.user!.birthDate = birthDateController.text;
          print("!!${_model!.user!.birthDate}");
          ProgressLoader(context, "your Birthdate Update SuccessFully");
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateVatNumber(vatNumberController, BuildContext context) {
    if (vatNumberController.text.isEmpty) {
      ErrorLoader(context, "VatNumber Can Not Be Empty");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .updateBirthDate(vatNumberController.text, context)
          .then((updateVatNumberSuccessResponse) {
        if (updateVatNumberSuccessResponse.success!) {
          setIsLogging(false);
          _model!.user!.vatNumber = vatNumberController.text;
          print("!!${_model!.user!.vatNumber}");
          ProgressLoader(context, "your VatNumber Update SuccessFully");
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  var currentPasswordController = TextEditingController();
  var newPasswordController = TextEditingController();
  var confirmNewPasswordController = TextEditingController();

  updatePassword(String currentPassword, String newPassword,
      String confirmPassword, BuildContext context) {
    if (currentPassword.isEmpty ||
        newPassword.isEmpty ||
        confirmPassword.isEmpty) {
      ErrorLoader(context, "Please Fill All The Field");
      notifyListeners();
    } else if (newPassword != confirmPassword) {
      ErrorLoader(context, "Password do not match");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .updatePassword(currentPassword, newPassword, context)
          .then((updatePasswordSuccessResponse) {
        if (updatePasswordSuccessResponse.success!) {
          setIsLogging(false);
          currentPassword;
          newPassword;
          print("CurrentPassword $currentPassword");
          print("NewPassword $newPassword");
          print("ConfirmNewPassword $newPassword");
          ProgressLoader(context, "your Password Update SuccessFully");
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  clearEditProfileProvider() {
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
    //notifyListeners();
  }
}
