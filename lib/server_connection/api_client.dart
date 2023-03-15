import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/my_profile/model/request_change_phonenumber_response.dart';
import 'package:g_worker_app/my_profile/model/update_birthdate_response.dart';
import 'package:g_worker_app/my_profile/model/update_email_response.dart';
import 'package:g_worker_app/my_profile/model/update_name_response.dart';
import 'package:g_worker_app/my_profile/model/update_password_response.dart';
import 'package:g_worker_app/my_profile/model/update_phonenumber_response.dart';
import 'package:g_worker_app/my_profile/model/update_vatnumber_response.dart';
import 'package:g_worker_app/my_profile/model/verify_phonenumber_otp_response.dart';
import 'package:g_worker_app/recover_password/model/change_password_response.dart';
import 'package:g_worker_app/recover_password/model/otp_verify_response.dart';
import 'package:g_worker_app/recover_password/model/request_otp_response.dart';
import 'package:g_worker_app/sign_up/model/check_email_response.dart';
import 'package:g_worker_app/sign_up/model/check_mobile_number_response.dart';
import 'package:g_worker_app/sign_up/model/otp_response.dart';
import 'package:g_worker_app/sign_in/model/sign_in_request.dart';
import 'package:g_worker_app/sign_in/model/sign_in_response.dart';
import 'package:g_worker_app/sign_in/provider/sign_in_provider.dart';
import 'package:g_worker_app/sign_up/model/verify_otp_response.dart';
import 'package:g_worker_app/sign_up/provider/sign_up_provider.dart';

import 'package:provider/provider.dart';

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
      print('ApiClient.adminLogin Error :: \ne');
      rethrow;
    }
  }

  Future<SignUpModel> userRegister({
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
      var request = json.encode({
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "password": password,
        "vat_number": vatNumber,
        "birth_date": birthDate,
        "role": role,
        "card_holder_name": cardHolderName,
        "card_number": cardNumber,
        "card_expiry": cardExpiry,
        "card_cvv": cardCvv,
        "image": image,
      });
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.signUp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));
      print('REGISTER API :: ${response.data}');
      return SignUpModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.adminLogin Error :: \ne');
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
      rethrow;
    }
  }

  Future<CheckMobileNumberModel> checkMobileNumber(
      String phoneNumber, BuildContext context) async {
    try {
      var request = json.encode({"phone_number": phoneNumber});
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
      rethrow;
    }
  }

  Future<UpdateNameModel> updateName({
    required String name,
  }) async {
    try {
      var request = json.encode({"name": "raj"});
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.updateName}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return UpdateNameModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<UpdateNameModel> updateLastName({
    required String lastName,
  }) async {
    try {
      var request = json.encode({"surname": "johnson"});
      var response = await dio.put(
          '${API.baseUrl}${ApiEndPoints.updateLastName}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return UpdateNameModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<UpdatePasswordModel> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      var request =
          json.encode({"old_password": "Jk123@", "new_password": "password"});
      var response = await dio.put(
          '${API.baseUrl}${ApiEndPoints.updatePassword}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return UpdatePasswordModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<UpdateEmailModel> updateEmail({
    required String email,
  }) async {
    try {
      var request = json.encode({"email": "test123@gmail.com"});
      var response = await dio.put(
          '${API.baseUrl}${ApiEndPoints.updatePassword}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return UpdateEmailModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<UpdateBirthDateModel> updateBirthDate({
    required String birthDate,
  }) async {
    try {
      var request = json.encode({"birth_date": "31/05/2001"});
      var response = await dio.put(
          '${API.baseUrl}${ApiEndPoints.updateBirthDate}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return UpdateBirthDateModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<UpdateVatNumberModel> updateVatNumber({
    required String vatNumber,
  }) async {
    try {
      var request = json.encode({"vat_number": "52525252525"});
      var response = await dio.put(
          '${API.baseUrl}${ApiEndPoints.updateVatNumber}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return UpdateVatNumberModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<RequestChangePhoneNumberModel> requestChangePhoneNumber({
    required String phoneNumber,
  }) async {
    try {
      var request = json.encode({"phone_number": "+919033834715"});
      var response = await dio.post(
          '${API.baseUrl}${ApiEndPoints.requestChangePhoneNumber}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return RequestChangePhoneNumberModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<VerifyPhoneNumberOtpModel> verifyPhoneNumberOtp({
    required String otp,
  }) async {
    try {
      var request = json.encode({"otp": "1252"});
      var response = await dio.post(
          '${API.baseUrl}${ApiEndPoints.verifyPhoneNumberOtp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return VerifyPhoneNumberOtpModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<UpdatePhoneNumberModel> updatePhoneNumber({
    required String credentialToken,
    required String phoneNumber,
  }) async {
    try {
      var request = json.encode({
        "credentials_token": "6cbjyU79cwDIesoJ99nGGjZjGtIXoVAp",
        "phone_number": "+919033834715"
      });
      var response = await dio.put(
          '${API.baseUrl}${ApiEndPoints.updatePhoneNumber}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return UpdatePhoneNumberModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<OtpVerifyModel> otpVerify({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      var request = json.encode({
        "phone_number": "+919033834715",
        "otp": "2841",
      });
      var response = await dio.post(
          '${API.baseUrl}${ApiEndPoints.otpVerifyPhone}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return OtpVerifyModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<RequestOtpModel> requestOtp({
    required String phoneNumber,
  }) async {
    try {
      var request = json.encode({
        "phone_number": "+919033834715",
      });
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.requestOtp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return RequestOtpModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<ChangePasswordModel> changePassword({
    required String token,
    required String password,
  }) async {
    try {
      var request = json.encode({
        "token": "6cbjyU79cwDIesoJ99nGGjZjGtIXoVAp",
        "password": "password",
      });
      var response = await dio.post(
          '${API.baseUrl}${ApiEndPoints.changePassword}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return ChangePasswordModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }
}
