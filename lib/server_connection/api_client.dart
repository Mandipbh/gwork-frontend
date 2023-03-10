import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/sign_in/model/sign_in_request.dart';
import 'package:g_worker_app/sign_in/model/sign_in_response.dart';
import 'package:g_worker_app/sign_in/provider/sign_in_provider.dart';

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
      required String image,}
  ) async {
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
      var response = await dio.post('${API.baseUrl}${ApiEndPoints.signUp}',
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
}
