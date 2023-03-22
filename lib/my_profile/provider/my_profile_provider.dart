import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/my_profile/model/get_profile_response.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/code_confirmation_screen.dart';

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

    if (_model != null && _model!.user!.image != null) {
      _model!.user!.name!;
      _model!.user!.surname!;
      _model!.user!.email!;
      _model!.user!.phoneNumber!;
      _model!.user!.birthDate!;
      _model!.user!.vatNumber!;
      _model!.user!.image!;
      notifyListeners();
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

  updatePhone(phoneController, BuildContext context) {
    if (phoneController.text.isEmpty) {
      ErrorLoader(context, "Phone Number Can Not Be Empty");
      notifyListeners();
    } else {
      setIsLogging(true);
      ApiClient()
          .requestChangePhoneNumber(phoneController.text, context)
          .then((requestChangePhoneSuccessResponse) {
        if (requestChangePhoneSuccessResponse.success!) {
          setIsLogging(false);
          _model!.user!.phoneNumber = phoneController.text;
          print("!!${_model!.user!.phoneNumber}");
          ProgressLoader(context,
              "your Phone Number Update SuccessFully ${requestChangePhoneSuccessResponse.otp}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CodeConfirmationScreen(
                  comingFrom: 3, phoneNumber: phoneController.text),
            ),
          );
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
          .updateVatNumber(vatNumberController.text, context)
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

  updateProfileImage(profileImage, BuildContext context) {
    setIsLogging(true);
    ApiClient()
        .updateProfileImage(profileImage, context)
        .then((updateProfileImageSuccessResponse) {
      if (updateProfileImageSuccessResponse.success!) {
        setIsLogging(false);
        _model!.user!.image = profileImage;
        ProgressLoader(context, "your ProfilePicture Update SuccessFully");
        Navigator.of(context).pop();
        getUserProfile(context);
        notifyListeners();
        return true;
      }
    });
  }

  deleteProfileImage(BuildContext context) {
    setIsLogging(true);
    ApiClient()
        .removeProfileImage(context)
        .then((updateProfileImageSuccessResponse) {
      if (updateProfileImageSuccessResponse.success!) {
        print("DELETE IMAGE ==> ${updateProfileImageSuccessResponse.success}");
        //
        setIsLogging(false);
        ProgressLoader(context, "your ProfilePicture delete SuccessFully");
        Navigator.of(context).pop();
        getUserProfile(context);
        notifyListeners();
        return true;
      }
    });
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
