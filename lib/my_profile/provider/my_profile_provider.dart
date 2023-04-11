import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/my_profile/model/get_profile_response.dart';
import 'package:g_worker_app/recover_password/recover_password_widgets/code_confirmation_screen.dart';

import '../../server_connection/api_client.dart';

class MyProfileProvider extends ChangeNotifier {
  GetProfileModel? _model;
  GetProfileModel? get model => _model;
  bool _isLoading = false;
  bool getIsLoading() => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isProfileDataLoading = true;

  bool getIsLoadingProfile() => _isProfileDataLoading;

  setIsLoadingProfile(bool value) {
    _isProfileDataLoading = value;
    notifyListeners();
  }

  getUserProfile(BuildContext context) async {
    _model = await ApiClient().getProfile(context);
    setIsLoadingProfile(false);
  }

  clearProfileProvider() {
    _model = null;
    notifyListeners();
  }

  updateName(nameController, BuildContext context) {
    if (nameController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (nameController.text.length < 3) {
      ErrorLoader(context, tr("error_message.valid_name"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .updateName(nameController.text, context)
          .then((updateNameSuccessResponse) {
        if (updateNameSuccessResponse.success!) {
          setIsLoading(false);
          _model!.user!.name = nameController.text;
          print("!!${_model!.user!.name}");
          ProgressLoader(context, tr("success_message.setting_update"));
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateLastName(lastNameController, BuildContext context) {
    if (lastNameController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (lastNameController.text.length < 3) {
      ErrorLoader(context, tr("error_message.valid_last_name"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .updateLastName(lastNameController.text, context)
          .then((updateLastNameSuccessResponse) {
        if (updateLastNameSuccessResponse.success!) {
          setIsLoading(false);
          _model!.user!.surname = lastNameController.text;
          print("!!${_model!.user!.surname}");
          ProgressLoader(context, tr("success_message.setting_update"));
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateEmail(emailController, BuildContext context) {
    if (emailController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(emailController)) {
      ErrorLoader(context, tr("error_message.valid_email"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .updateEmail(emailController.text, context)
          .then((updateEmailSuccessResponse) {
        if (updateEmailSuccessResponse.success!) {
          setIsLoading(false);
          _model!.user!.email = emailController.text;
          print("!!${_model!.user!.email}");
          ProgressLoader(context, tr("success_message.setting_update"));
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updatePhone(phoneController, BuildContext context) {
    if (phoneController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (phoneController.text.length < 10) {
      ErrorLoader(context, tr("error_message.valid_phone"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .requestChangePhoneNumber(phoneController.text, context)
          .then((requestChangePhoneSuccessResponse) {
        if (requestChangePhoneSuccessResponse.success!) {
          setIsLoading(false);
          _model!.user!.phoneNumber = phoneController.text;
          print("!!${_model!.user!.phoneNumber}");
          ProgressLoader(context, "Otp Send SuccessFully ${requestChangePhoneSuccessResponse.otp}");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CodeConfirmationScreen(
                  comingFrom: 3, phoneNumber: phoneController.text),
            ),
          );
          ProgressLoader(context,
              "${tr("success_message.otp_send")} \n+39 ${phoneController.text}");
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateBirthDate(birthDateController, BuildContext context) {
    if (birthDateController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .updateBirthDate(birthDateController.text, context)
          .then((updateEmailSuccessResponse) {
        if (updateEmailSuccessResponse.success!) {
          setIsLoading(false);
          _model!.user!.birthDate = birthDateController.text;
          print("!!${_model!.user!.birthDate}");
          ProgressLoader(context, tr("success_message.setting_update"));
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateVatNumber(vatNumberController, BuildContext context) {
    if (vatNumberController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .updateVatNumber(vatNumberController.text, context)
          .then((updateVatNumberSuccessResponse) {
        if (updateVatNumberSuccessResponse.success!) {
          setIsLoading(false);
          _model!.user!.vatNumber = vatNumberController.text;
          print("!!${_model!.user!.vatNumber}");
          ProgressLoader(context, tr("success_message.setting_update"));
          Navigator.of(context).pop();
          notifyListeners();
          return true;
        }
      });
    }
  }

  updateProfileImage(profileImage, BuildContext context) {
    setIsLoading(true);
    ApiClient()
        .updateProfileImage(profileImage, context)
        .then((updateProfileImageSuccessResponse) {
      if (updateProfileImageSuccessResponse.success!) {
        setIsLoading(false);
        _model!.user!.image = profileImage;
        ProgressLoader(context, tr("success_message.setting_update"));
        getUserProfile(context);
        notifyListeners();
        return true;
      }
    });
  }

  deleteProfileImage(BuildContext context) {
    setIsLoading(true);
    ApiClient()
        .removeProfileImage(context)
        .then((updateProfileImageSuccessResponse) {
      if (updateProfileImageSuccessResponse.success!) {
        print("DELETE IMAGE ==> ${updateProfileImageSuccessResponse.success}");
        //
        setIsLoading(false);
        ProgressLoader(
            context, tr("success_message.delete_profile_pic_success"));
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
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
    } else if (newPassword != confirmPassword) {
      ErrorLoader(context, tr("error_message.pass_doNot_coincide"));
      notifyListeners();
    } else if (newPassword.length <= 7) {
      ErrorLoader(context, tr("error_message.try_with_new_pass"));
      notifyListeners();
    } else {
      setIsLoading(true);
      ApiClient()
          .updatePassword(currentPassword, newPassword, context)
          .then((updatePasswordSuccessResponse) {
        if (updatePasswordSuccessResponse.success!) {
          setIsLoading(false);
          currentPassword;
          newPassword;
          print("CurrentPassword $currentPassword");
          print("NewPassword $newPassword");
          print("ConfirmNewPassword $newPassword");
          Navigator.of(context).pop();
          ProgressLoader(context, tr("success_message.setting_update"));
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
