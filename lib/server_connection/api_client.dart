import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/my_profile/model/get_profile_response.dart';
import 'package:g_worker_app/my_profile/model/request_change_phone_response.dart';
import 'package:g_worker_app/my_profile/model/verify_phonenumber_otp_response.dart';
import 'package:g_worker_app/my_profile/provider/my_profile_provider.dart';
import 'package:g_worker_app/recover_password/model/otp_request_model.dart';
import 'package:g_worker_app/recover_password/model/otp_verify_response.dart';
import 'package:g_worker_app/recover_password/provider/recover_password_provider.dart';
import 'package:g_worker_app/sign_up/model/check_email_response.dart';
import 'package:g_worker_app/sign_up/model/check_mobile_number_response.dart';
import 'package:g_worker_app/sign_up/model/otp_response.dart';
import 'package:g_worker_app/sign_in/model/sign_in_request.dart';
import 'package:g_worker_app/sign_in/model/sign_in_response.dart';
import 'package:g_worker_app/sign_in/provider/sign_in_provider.dart';
import 'package:g_worker_app/sign_up/model/verify_otp_response.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';
import 'package:g_worker_app/sign_up/sign_up_widgets/upload_document_view/document_provider/document_provider.dart';
import 'package:g_worker_app/success_model/success_model_response.dart';

import 'package:provider/provider.dart';

import '../shared_preference_data.dart';
import '../sign_up/model/sign_up_response.dart';

class ApiClient {
  Dio dio = Dio();

  Future<SignInResponse> login(
      SignInRequest request, BuildContext context) async {
    try {
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.login}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      return SignInResponse.fromJson(response.data);
    } on DioError {
      log("https1");
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<SignInProvider>(context, listen: false).setIsLogging(false);
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<SignInProvider>(context, listen: false).setIsLogging(false);
      log("https2");
      print('ApiClient.adminLogin Error :: \ne');
      rethrow;
    }
  }

  Future<SignInResponse> adminLogin(SignInRequest request) async {
    try {
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.adminLogin}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      return SignInResponse.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.adminLogin Error :: \n$e');
      rethrow;
    }
  }

  Future<SignUpModel> userRegister(
    BuildContext context, {
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? password,
    String? vatNumber,
    String? birthDate,
    String? role,
    String? cardHolderName,
    String? cardNumber,
    String? cardExpiry,
    String? cardCvv,
    String? image,
  }) async {
    print("firstName ==> $firstName");
    print("lastName ==> $lastName");
    print("email ==> $email");
    print("phoneNumber ==> $phoneNumber");
    print("password ==> $password");
    print("vatNumber ==> $vatNumber");
    print("role ==> $role");
    print("cardHolderName ==> $cardHolderName");
    print("cardNumber ==> $cardNumber");
    print("cardExpiry ==> $cardExpiry");
    print("cardCvv ==> $cardCvv");
    print("image ==> $image");

    try {
      print("@@@");

      dio.options.headers["Content-Type"] = "multipart/form-data";
      FormData formData =
          Provider.of<SignUpProvider>(context, listen: false).userType == 0
              ? FormData.fromMap({
                  "first_name": firstName,
                  "last_name": lastName,
                  "email": email,
                  "phone_number": '+39$phoneNumber',
                  "password": password,
                  "vat_number": vatNumber,
                  "birth_date": birthDate,
                  "role": role,
                  "card_holder_name": cardHolderName,
                  "card_number": cardNumber,
                  "card_expiry": cardExpiry,
                  "card_cvv": cardCvv,
                  'image': await MultipartFile.fromFile('$image',
                      filename: image!.split('/').last),
                })
              : FormData.fromMap({
                  "first_name": firstName,
                  "last_name": lastName,
                  "email": email,
                  "phone_number": '+39$phoneNumber',
                  "password": password,
                  "vat_number": vatNumber,
                  "birth_date": birthDate,
                  "role": role,
                  "card_holder_name": cardHolderName,
                  "card_number": cardNumber,
                  "card_expiry": cardExpiry,
                  "card_cvv": cardCvv,
                  'image': await MultipartFile.fromFile('$image',
                      filename: image!.split('/').last),
                  'docs': await MultipartFile.fromFile(
                    '${Provider.of<DocumentPicProvider>(context, listen: false).docList[1]}',
                  ),
                });

      var response = await dio.put('${API.baseUrl}${ApiEndPoints.signUp}',
          data: formData,
          options: Options(headers: {'Content-Type': 'application/json'}));
      print('REGISTER API :: ${response.data}');
      return SignUpModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(context, "Error in registration");
      Provider.of<SignUpProvider>(context, listen: false).setIsLogging(false);
      rethrow;
    } catch (e) {
      ErrorLoader(context, "Error in registration");
      Provider.of<SignUpProvider>(context, listen: false).setIsLogging(false);
      print('ApiClient.adminLogin Error :: \n$e');
      rethrow;
    }
  }

  Future<OtpModel> getOtp(
    String phoneNumber,
    BuildContext context,
  ) async {
    try {
      var request = json.encode({"phone_number": phoneNumber});
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.getOtp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      print('ApiClient.GET OTP  :: \ne${response.data}');
      print('ApiClient.GET OTP  :: \ne$phoneNumber');
      return OtpModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<SignUpProvider>(context, listen: false).setIsLogging(false);
      print("----DIO ERROR GET OTP----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<SignUpProvider>(context, listen: false).setIsLogging(false);
      print("----CATCH ERROR GET OTP----");
      print('ApiClient.GetOtp Error :: \n$e');
      rethrow;
    }
  }

  Future<CheckMobileNumberModel> checkMobileNumber(
      String phoneNumber, BuildContext context) async {
    try {
      var request = json.encode({"phone_number": '+39$phoneNumber'});
      var response = await dio.post(
          '${API.baseUrl}${ApiEndPoints.checkMobileNumber}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      print('ApiClient.checkMobileNo  :: \ne${response.data}');
      print('ApiClient.checkMobileNo  :: \ne$phoneNumber');
      return CheckMobileNumberModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<SignUpProvider>(context, listen: false).setIsLogging(false);
      print("----DIO ERROR CHECK MOBILENUMBER----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<SignUpProvider>(context, listen: false).setIsLogging(false);
      print("----CATCH ERROR CHECK MOBILENUMBER----");
      print('ApiClient.CheckMobileNumber Error :: \n$e');
      rethrow;
    }
  }

  Future<CheckEmailModel> checkEmail({
    required String email,
  }) async {
    try {
      var request = json.encode({"email": "jaynikpatel119977.jp@gmail.com"});
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.checkEmail}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return CheckEmailModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<VerifyOtpModel> verifyOtp(
      String phoneNumber, String otp, BuildContext context) async {
    try {
      var request = json.encode({
        "phone_number": phoneNumber,
        "otp": otp,
      });
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.verifyOtp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      print('ApiClient.verify Otp  :: \ne$phoneNumber');
      print('ApiClient.verify Otp  :: \ne${response.data}');
      return VerifyOtpModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<SignUpProvider>(context, listen: false).setIsLogging(false);
      print("----DIO ERROR Verify Otp----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<SignUpProvider>(context, listen: false).setIsLogging(false);
      print("----CATCH ERROR Verify Otp----");
      print('ApiClient.getOtp Error :: \n$e');
      rethrow;
    }
  }

  Future<SuccessDataModel> updateName(String name, BuildContext context) async {
    try {
      var request = json.encode({"name": name});
      print("NAME :: $name");
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.updateName}',
          data: request,
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));
      print("UPDATENAME :: $name");
      print("UPDATENAME :: ${response.data}");
      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Name----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----CATCH ERROR Update Name----");
      print('ApiClient.UpdateName Error :: \n$e');
      rethrow;
    }
  }

  Future<SuccessDataModel> updateLastName(
    String lastName,
    BuildContext context,
  ) async {
    try {
      var request = json.encode({"surname": lastName});
      var response =
          await dio.put('${API.baseUrl}${ApiEndPoints.updateLastName}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));
      print("!LAST NAme!!!${response.data}");
      print("@@$lastName");
      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Last Name----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Last Name----");
      print('ApiClient.UpdateLastName Error :: \n$e');
      rethrow;
    }
  }

  Future<GetProfileModel> getProfile(BuildContext context) async {
    try {
      var request = json.encode({"surname": "johnson"});
      var response = await dio.get('${API.baseUrl}${ApiEndPoints.getProfile}',
          data: request,
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));
      print("GET PROFILE :: ${response.data}");
      return GetProfileModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Get Profile----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----CATCH ERROR Get Profile----");
      print('ApiClient.GetProfile Error :: \n$e');
      rethrow;
    }
  }

  Future<SuccessDataModel> updatePassword(
      String oldPassword, String newPassword, BuildContext context) async {
    try {
      var request = json
          .encode({"old_password": oldPassword, "new_password": newPassword});
      var response =
          await dio.put('${API.baseUrl}${ApiEndPoints.updatePassword}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));

      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Password----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Password----");
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<SuccessDataModel> updateEmail(
    String email,
    BuildContext context,
  ) async {
    try {
      var request = json.encode({"email": email});
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.updateEmail}',
          data: request,
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Email----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Email----");
      print('ApiClient.upDateEmail Error :: \ne');
      rethrow;
    }
  }

  Future<SuccessDataModel> updateProfileImage(
    String image,
    BuildContext context,
  ) async {
    try {
      var request = json.encode({"image": image});
      var response =
          await dio.put('${API.baseUrl}${ApiEndPoints.updateProfileImage}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));
      print("response image ${response.data}");
      // Provider.of<MyProfileProvider>(context, listen: false)
      //     .getUserProfile(context);

      //_model!.user!.image = profileImage;
      // ProgressLoader(context, "your ProfilePicture Update SuccessFully");
      // Navigator.of(context).pop();

      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Image----");
      rethrow;
    } catch (e) {
      // ErrorLoader(
      //     context, "Oops, something is wrong with your data. Try again.");
      // Provider.of<MyProfileProvider>(context, listen: false)
      //     .setIsLogging(false);
      print("----DIO ERROR Update Email----");
      print('ApiClient.upDateImage Error :: $e');
      rethrow;
    }
  }

  Future<SuccessDataModel> updateBirthDate(
      String birthDate, BuildContext context) async {
    try {
      var request = json.encode({"birth_date": birthDate});
      var response =
          await dio.put('${API.baseUrl}${ApiEndPoints.updateBirthDate}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));
      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update Birthdate----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update birthdate----");
      print('ApiClient.updateBirthdate Error :: $e');
      rethrow;
    }
  }

  Future<SuccessDataModel> updateVatNumber(
      String vatNumber, BuildContext context) async {
    try {
      var request = json.encode({"vat_number": vatNumber});
      var response =
          await dio.put('${API.baseUrl}${ApiEndPoints.updateVatNumber}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));

      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update VatNumber----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update VatNumber----");
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<RequestChangePhoneModel> requestChangePhoneNumber(
      String phoneNumber, BuildContext context) async {
    try {
      print("Phone==> $phoneNumber");
      var request = json.encode({"phone_number": "+39$phoneNumber"});
      var response = await dio.post(
          '${API.baseUrl}${ApiEndPoints.requestChangePhoneNumber}',
          data: request,
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));
      print("Phone1==> $phoneNumber");
      print("RequestChangePhone==> ${response.data}");
      return RequestChangePhoneModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update requestChangePhone----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Update requestChangePhone----");
      print('ApiClient.requestChangePhone Error :: $e');
      rethrow;
    }
  }

  Future<VerifyPhoneNumberOtpModel> verifyPhoneNumberOtp(
      String otp, BuildContext context) async {
    try {
      var request = json.encode({"otp": otp});
      print("Otp==> $otp");
      var response =
          await dio.post('${API.baseUrl}${ApiEndPoints.verifyPhoneNumberOtp}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));
      print("Otp1==> $otp");
      print("VerifyPhoneOtp==> ${response.data}");
      return VerifyPhoneNumberOtpModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR verifyPhoneOtp----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR verifyPhoneOtp----");
      print('ApiClient.getOtp Error :: $e');
      rethrow;
    }
  }

  // Future<UpdatePhoneNumberModel> updatePhoneNumber({
  //   required String credentialToken,
  //   required String phoneNumber,
  // }) async {
  //   try {
  //     var request = json.encode({
  //       "credentials_token": "6cbjyU79cwDIesoJ99nGGjZjGtIXoVAp",
  //       "phone_number": "+919033834715"
  //     });
  //     var response = await dio.put(
  //         '${API.baseUrl}${ApiEndPoints.updatePhoneNumber}',
  //         data: request,
  //         options: Options(headers: {'Content-Type': 'application/json'}));
  //
  //     return UpdatePhoneNumberModel.fromJson(response.data);
  //   } on DioError {
  //     rethrow;
  //   } catch (e) {
  //     print('ApiClient.getOtp Error :: \ne');
  //     rethrow;
  //   }
  // }

  Future<OtpVerifyModel> otpVerify(
      String phoneNumber, String otp, BuildContext context) async {
    try {
      var request = json.encode({
        "phone_number": "+39$phoneNumber",
        "otp": otp,
      });
      var response =
          await dio.post('${API.baseUrl}${ApiEndPoints.otpVerifyPhone}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));
      print("OtpVerify :: $phoneNumber");
      print("OtpVerify :: ${response.data}");
      return OtpVerifyModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR  Otp Verify----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR  Otp Verify----");
      print('ApiClient.otpVerify Error :: $e');
      rethrow;
    }
  }

  Future<RequestOtpModel> requestOtp(
      String phoneNumber, BuildContext context) async {
    try {
      var request = json.encode({
        "phone_number": "+39$phoneNumber",
      });
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.requestOtp}',
          data: request,
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));
      print("RequestOtpPhone :: $phoneNumber");
      print("RequestOtpPhone :: ${response.data}");
      return RequestOtpModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Request Otp----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Request Otp----");
      print('ApiClient.requestOtp Error :: $e');
      rethrow;
    }
  }

  Future<SuccessDataModel> changePassword(
    String token,
    String password,
    BuildContext context,
  ) async {
    try {
      print("Token :: $token");
      print("Password :: $password");
      var request = json.encode({
        "token": token,
        "password": password,
      });
      var response =
          await dio.post('${API.baseUrl}${ApiEndPoints.changePassword}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
              }));
      print("Token1 :: $token");
      print("Password1 :: $password");
      print("ChangePassword :: ${response.data}");
      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Change Password----");
      rethrow;
    } catch (e) {
      ErrorLoader(
          context, "Oops, something is wrong with your data. Try again.");
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLogging(false);
      print("----DIO ERROR Change Password----");
      print('ApiClient.Change Password Error :: $e');
      rethrow;
    }
  }
}
