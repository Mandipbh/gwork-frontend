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
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String password,
    required String vatNumber,
    required String birthDate,
    required String role,
    required String cardHolderName,
    required String cardNumber,
    required String cardExpiry,
    required String image,
  }) async {
    try {
      var request = json.encode({
        "first_name": "jaynik",
        "last_name": "patel",
        "email": "jaynikpatel119977.jp@gmail.com",
        "phone_number": "9033834715",
        "password": "Jk123@",
        "vat_number": "12345",
        "birth_date": "31/12/2002",
        "role": "0",
        "card_holder_name": "patel",
        "card_number": "122212221222",
        "card_expiry": "05/25",
        "card_cvv": "555",
        "image": ""
      });
      var response = await dio.put('${API.baseUrl}${ApiEndPoints.signUp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return SignUpModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.adminLogin Error :: \ne');
      rethrow;
    }
  }

  Future<OtpModel> getOtp({
    required String phoneNumber,
  }) async {
    try {
      var request = json.encode({"phone_number": "+919033834715"});
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.getOtp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return OtpModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
      rethrow;
    }
  }

  Future<CheckMobileNumberModel> checkMobileNumber({
    required String phoneNumber,
  }) async {
    try {
      var request = json.encode({"phone_number": "+919033834715"});
      var response = await dio.post(
          '${API.baseUrl}${ApiEndPoints.checkMobileNumber}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return CheckMobileNumberModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
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

  Future<VerifyOtpModel> verifyOtp({
    required String phoneNumber,
    required String otp,
  }) async {
    try {
      var request = json.encode({
        "phone_number": "+919033834715",
        "otp": "8376",
      });
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.verifyOtp}',
          data: request,
          options: Options(headers: {'Content-Type': 'application/json'}));

      return VerifyOtpModel.fromJson(response.data);
    } on DioError {
      rethrow;
    } catch (e) {
      print('ApiClient.getOtp Error :: \ne');
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

  void base64EncodeFile(List<dynamic> args) {
    final SendPort sendPort = args[0] as SendPort;
    final File file = args[1] as File;
    Uint8List imgBytes = file.readAsBytesSync();
    String imageBase64 = base64Encode(imgBytes.toList());
    sendPort.send(imageBase64);
  }

  Future<String> upLoadImage(File image) async {
    final receivePort = ReceivePort();
    Isolate.spawn(base64EncodeFile, [receivePort.sendPort, image]);
    final dynamic imageBase64 = await receivePort.first;
    return imageBase64 as String;
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
