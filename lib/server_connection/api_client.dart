import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/jobs/add_job_widgets/upload_images_view.dart';
import 'package:g_worker_app/jobs/model/create_client_job_response.dart';
import 'package:g_worker_app/jobs/model/get_client_job_list_response.dart';
import 'package:g_worker_app/jobs/model/get_job_details_client_model.dart';
import 'package:g_worker_app/jobs/model/get_prof_job_details_model.dart';
import 'package:g_worker_app/jobs/model/get_professional_job_response.dart';
import 'package:g_worker_app/jobs/provider/create_client_job_provider.dart';
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

import '../jobs/model/get_client_job_applications_model.dart';
import '../jobs/model/job_status_update_response.dart';
import '../province/province_model.dart';
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<SignInProvider>(context, listen: false).setIsLogging(false);
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
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

  Future<CreateClientJobModel?> userRegister(
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

      var formData = FormData();
      for (var file
          in Provider.of<DocumentPicProvider>(context, listen: false).docList) {
        formData.files.addAll([
          if (!file.contains("add"))
            MapEntry("docs", await MultipartFile.fromFile(file)),
        ]);
      }

      Provider.of<SignUpProvider>(context, listen: false).userType == 0
          ? formData.fields.addAll([
              MapEntry("first_name", firstName!),
              MapEntry("last_name", lastName!),
              MapEntry("email", email!),
              MapEntry(
                "phone_number",
                '+39$phoneNumber',
              ),
              MapEntry("password", password!),
              MapEntry("vat_number", vatNumber!),
              MapEntry("birth_date", birthDate!),
              const MapEntry("role", '${0}'),
              MapEntry("card_holder_name", cardHolderName!),
              MapEntry("card_number", cardNumber!),
              MapEntry("card_expiry", cardExpiry!),
              MapEntry("card_cvv", cardCvv!),
            ])
          : formData.fields.addAll([
              MapEntry("first_name", firstName!),
              MapEntry("last_name", lastName!),
              MapEntry("email", email!),
              MapEntry(
                "phone_number",
                '+39$phoneNumber',
              ),
              MapEntry("password", password!),
              MapEntry("vat_number", vatNumber!),
              MapEntry("birth_date", birthDate!),
              const MapEntry("role", '${1}'),
              MapEntry("card_holder_name", cardHolderName!),
              MapEntry("card_number", cardNumber!),
              MapEntry("card_expiry", cardExpiry!),
              MapEntry("card_cvv", cardCvv!),
            ]);
      formData.files.addAll([
        MapEntry("image", await MultipartFile.fromFile(image!)),
      ]);
      var response = await dio.put(
        '${API.baseUrl}${ApiEndPoints.signUp}',
        data: formData,
        //options: Options(headers: {'Content-Type': 'application/json'})
      );
      print('REGISTER API :: ${response.data}');
      return CreateClientJobModel.fromJson(response.data);
    } on DioError catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<SignUpProvider>(context, listen: false).setIsLoading(false);
      CreateClientJobModel();
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<SignUpProvider>(context, listen: false).setIsLoading(false);
      print('ApiClient.adminLogin Error :: \n$e');
      CreateClientJobModel();
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<SignUpProvider>(context, listen: false).setIsLoading(false);
      print("----DIO ERROR CHECK MOBILENUMBER----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<SignUpProvider>(context, listen: false).setIsLoading(false);
      print("----CATCH ERROR CHECK MOBILENUMBER----");
      print('ApiClient.CheckMobileNumber Error :: \n$e');
      rethrow;
    }
  }

  Future<OtpModel> getOtp(
    String phoneNumber,
    BuildContext context,
  ) async {
    try {
      var request = json.encode({"phone_number": "+39$phoneNumber"});
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.getOtp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      print('ApiClient.GET OTP  :: \ne${response.data}');
      print('ApiClient.GET OTP  :: \ne$phoneNumber');
      return OtpModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<SignUpProvider>(context, listen: false).setIsLoading(false);
      print("----DIO ERROR GET OTP----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<SignUpProvider>(context, listen: false).setIsLoading(false);
      print("----CATCH ERROR GET OTP----");
      print('ApiClient.GetOtp Error :: \n$e');
      rethrow;
    }
  }

  Future<VerifyOtpModel> verifyOtp(
      String phoneNumber, String otp, BuildContext context) async {
    try {
      var request = json.encode({
        "phone_number": '+39$phoneNumber',
        "otp": otp,
      });
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.verifyOtp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      print('ApiClient.verify Otp  :: \ne$phoneNumber');
      print('ApiClient.verify Otp  :: \ne${response.data}');
      return VerifyOtpModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(context, tr("error_message.otp_not_correct"));
      Provider.of<SignUpProvider>(context, listen: false).setIsLoading(false);
      print("----DIO ERROR Verify Otp----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.otp_not_correct"));
      Provider.of<SignUpProvider>(context, listen: false).setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update Name----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update Last Name----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update Last Name----");
      print('ApiClient.UpdateLastName Error :: \n$e');
      rethrow;
    }
  }

  Future<GetProfileModel> getProfile(BuildContext context) async {
    try {
      // var request = json.encode();
      var response = await dio.get('${API.baseUrl}${ApiEndPoints.getProfile}',
          // data: request,
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));
      print("GET PROFILE :: ${response.data}");
      return GetProfileModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Get Profile----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update Password----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update Email----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update Image----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update Birthdate----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update VatNumber----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update requestChangePhone----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR verifyPhoneOtp----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR verifyPhoneOtp----");
      print('ApiClient.getOtp Error :: $e');
      rethrow;
    }
  }

  Future<SuccessDataModel> updatePhoneNumber(
      String token, String phoneNumber, BuildContext context) async {
    try {
      var request = json.encode(
          {"credentials_token": token, "phone_number": "+39$phoneNumber"});
      var response =
          await dio.put('${API.baseUrl}${ApiEndPoints.updatePhoneNumber}',
              data: request,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));
      return SuccessDataModel.fromJson(response.data);
    } on DioError catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      rethrow;
    }
  }

  Future<SuccessDataModel> removeProfileImage(BuildContext context) async {
    try {
      var response =
          await dio.delete('${API.baseUrl}${ApiEndPoints.removeProfileImage}',
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));

      return SuccessDataModel.fromJson(response.data);
    } on DioError {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      print('ApiClient.getOtp Error :: $e');
      rethrow;
    }
  }

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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR  Otp Verify----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLoading(false);
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
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Request Otp----");
      rethrow;
    } catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLoading(false);
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
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Change Password----");
      rethrow;
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<RecoverPasswordProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Change Password----");
      print('ApiClient.Change Password Error :: $e');
      rethrow;
    }
  }

  //GetClientJobList
  Future<GetClientJobListModel> getClientJobService(
      BuildContext context, String state, String category) async {
    GetClientJobListModel? _model;
    try {
      var response = await dio.get(
          '${API.baseUrl}${ApiEndPoints.getClientJobList}?state=$state&category=$category',
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      print("VerifyPhoneOtp==> ${response.data}");
      _model = GetClientJobListModel.fromJson(response.data);
      return _model;
    } on DioError catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return _model!;
  }

  //GetProfessionalJobList
  Future<GetProfessionalJobListModel> getProfessionalJobListService(
      {required BuildContext context,
      required String category,
      required String province,
      required bool isSelf,
      required String state,
      required String jobState}) async {
    GetProfessionalJobListModel? _model;
    var params = {
      "category": category,
      "is_self": isSelf,
      "province": province,
      "state": state,
      "job_state": jobState
    };
    try {
      var response =
          await dio.get('${API.baseUrl}${ApiEndPoints.getProfessionalJobList}',
              queryParameters: params,
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));
      _model = GetProfessionalJobListModel.fromJson(response.data);
      return _model;
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetProfessionalJobListModel();
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetProfessionalJobListModel();
    }
    return _model!;
  }

  Future<ProviceModel> getProvinceList(BuildContext context) async {
    ProviceModel? _model;
    try {
      var response =
          await dio.get('${API.baseUrl}${ApiEndPoints.getProvinceList}',
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));

      print("VerifyPhoneOtp==> ${response.data}");
      _model = ProviceModel.fromJson(response.data);
      return _model;
    } on DioError catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return _model!;
  }

  Future<CreateClientJobModel> createClientJob(
    String category,
    String title,
    String street,
    String commune,
    String date,
    String time,
    String description,
    String budget,
    BuildContext context,
  ) async {
    try {
      print("category :: $category");
      print("title :: $title");
      print("street :: $street");

      print("comune :: $commune");
      print("date :: $date");
      print("time :: $time");
      print("description :: $description");
      print("budget :: $budget");

      var formData = FormData();
      for (var file in Provider.of<UploadImageProvider>(context, listen: false)
          .imageList) {
        formData.files.addAll([
          if (!file.contains("add"))
            MapEntry("docs", await MultipartFile.fromFile(file)),
        ]);
      }

      formData.fields.addAll([
        MapEntry("category", "$category"),
        MapEntry("title", "$title"),
        MapEntry("street", "$street"),
        MapEntry(
            "province",
            Provider.of<SignUpProvider>(context, listen: false)
                .selectedProvince!),
        MapEntry("commune", "$commune"),
        MapEntry("date", "$date"),
        MapEntry("time", "$time"),
        MapEntry("description", "$description"),
        MapEntry("budget", "$budget"),
      ]);
      print("CreateClientJob :: ${formData.fields}");
      print("CreateClientJob :: ${formData.files}");

      var response =
          await dio.post('${API.baseUrl}${ApiEndPoints.createClientJobList}',
              data: formData,
              options: Options(headers: {
                'Content-Type': "multipart/form-data",
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));
      print("CreateClientJob :: ${response.data}");
      return CreateClientJobModel.fromJson(response.data);
    } on DioError catch (e) {
      log(e.response!.statusCode.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<CreateClientJobProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR CreateClientJob----");
      return CreateClientJobModel();
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<CreateClientJobProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Change Password----");
      print('ApiClient.CreateClientJob Error :: $e');
      return CreateClientJobModel();
    }
  }

  Future<GetClientJobOverviewModel> getClientJobDetailsService(
      BuildContext context, String jobId) async {
    GetClientJobOverviewModel? _model;
    try {
      var request = json.encode({"job_id": jobId});
      var response = await dio.post(
          data: request,
          '${API.baseUrl}${ApiEndPoints.getClientJobDetails}',
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      print("GetProf==> ${response.data}");
      _model = GetClientJobOverviewModel.fromJson(response.data);
      return _model;
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetClientJobOverviewModel();
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetClientJobOverviewModel();
    }
    return _model!;
  }

  Future<GetProfJobDetailsModel> getProfessionalJobDetailsService(
      BuildContext context, String jobId) async {
    GetProfJobDetailsModel? _model;
    try {
      var request = json.encode({"job_id": jobId});
      var response = await dio.post(
          data: request,
          '${API.baseUrl}${ApiEndPoints.getProfessionalJobDetails}',
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      print("GetProf==> ${response.data}");
      _model = GetProfJobDetailsModel.fromJson(response.data);
      return _model;
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetProfJobDetailsModel();
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetProfJobDetailsModel();
    }
    return _model!;
  }

  Future<GetGalleryDetailsModel> getGalleryDetailsService(
      BuildContext context, String jobId) async {
    GetGalleryDetailsModel? _model;
    try {
      var response = await dio.get(
          'https://gwork.macca.cloud/${ApiEndPoints.getGalleryDetails}?job_id=$jobId',
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      print("GetGallery==> ${response.data}");
      _model = GetGalleryDetailsModel.fromJson(response.data);
      return _model;
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetGalleryDetailsModel();
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetGalleryDetailsModel();
    }
    return _model!;
  }

  //Apply for job Professional

  Future<SuccessDataModel?> applyForJobProfessional(
      String jobId, int price, BuildContext context) async {
    try {
      var response = await dio.post(
          '${API.baseUrl}${ApiEndPoints.applyForJobProfessional}',
          data: {"job_id": jobId, "price": price},
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      print("UPDATENAME :: ${response.data}");

      return SuccessDataModel.fromJson(response.data);
    } on DioError catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----DIO ERROR Update Name----");
      SuccessDataModel();
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      Provider.of<MyProfileProvider>(context, listen: false)
          .setIsLoading(false);
      print("----CATCH ERROR Update Name----");
      print('ApiClient.UpdateName Error :: \n$e');
      SuccessDataModel();
    }
    return null;
  }

  //getClient applications

  Future<GetClientApplicationsModel?> getClientApplications(
      BuildContext context, String jobId) async {
    GetClientApplicationsModel? _model;
    try {
      var response = await dio.get(
          '${API.baseUrl}${ApiEndPoints.getClientJobApplications}?job_id=$jobId',
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      print("GetGallery==> ${response.data}");
      _model = GetClientApplicationsModel.fromJson(response.data);
      return _model;
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetClientApplicationsModel();
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
      GetClientApplicationsModel();
    }
  }

  Future<JobStatusUpdateResponse?> deleteJobAPI(
      {required String jobId, required BuildContext context}) async {
    try {
      var response = await dio.delete('${API.baseUrl}${ApiEndPoints.deleteJob}',
          queryParameters: {"job_id": jobId},
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      return JobStatusUpdateResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return null;
  }

  Future<JobStatusUpdateResponse?> approveOrRejectJob(
      {required String jobId,
      required int jobState,
      required BuildContext context}) async {
    try {
      var response =
          await dio.put('${API.baseUrl}${ApiEndPoints.rejectApproveJob}',
              data: {"job_id": jobId, "status": jobState},
              options: Options(headers: {
                'Content-Type': 'application/json',
                "Authorization":
                    "Bearer ${await SharedPreferenceData().getToken()}"
              }));

      return JobStatusUpdateResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return null;
  }

  Future<JobStatusUpdateResponse?> rejectJobProf(
      {required String jobId, required BuildContext context}) async {
    try {
      var response = await dio.delete(
          '${API.baseUrl}${ApiEndPoints.rejectJobProf}?job_id=$jobId',
          data: {"job_id": jobId},
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));
      log("REJECT JOB :: ${response.data}");
      return JobStatusUpdateResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return null;
  }

  Future<JobStatusUpdateResponse?> acceptJobAPI(
      {required String jobId,
      required String userId,
      required BuildContext context}) async {
    try {
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.acceptJob}',
          data: {"job_id": jobId, "user_id": userId},
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));
      log(response.data.toString());

      return JobStatusUpdateResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return null;
  }

  Future<JobStatusUpdateResponse?> startJobAPI(
      {required String jobId, required BuildContext context}) async {
    try {
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.startJob}',
          data: {"job_id": jobId},
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      return JobStatusUpdateResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return null;
  }

  Future<JobStatusUpdateResponse?> completeJobAPI(
      {required String jobId, required BuildContext context}) async {
    try {
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.completeJob}',
          data: {"job_id": jobId},
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      return JobStatusUpdateResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return null;
  }

  Future<JobStatusUpdateResponse?> editJobOffer(
      {required String jobId,
      required String budget,
      required BuildContext context}) async {
    try {
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.completeJob}',
          data: {"job_id": jobId, "": budget},
          options: Options(headers: {
            'Content-Type': 'application/json',
            "Authorization": "Bearer ${await SharedPreferenceData().getToken()}"
          }));

      return JobStatusUpdateResponse.fromJson(response.data);
    } on DioError catch (e) {
      log(e.toString());
      ErrorLoader(context, tr("error_message.oops_wrong"));
    } catch (e) {
      ErrorLoader(context, tr("error_message.oops_wrong"));
    }
    return null;
  }
}
