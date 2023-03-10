import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:g_worker_app/shared_preference_data.dart';
import 'package:g_worker_app/sign_in/model/sign_in_request.dart';
import 'package:g_worker_app/sign_in/model/sign_in_response.dart';
import 'package:g_worker_app/validations.dart';

class SignInProvider extends ChangeNotifier {
  final StreamController<SignInResponse> _loginResponse = StreamController.broadcast();
  SharedPreferenceData preferenceData = SharedPreferenceData();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isLogging = false;
  int _selected = SelectionType.signIn;

  int getSelected() => _selected;

  bool getIsLogging() => _isLogging;

  Stream<SignInResponse> getLoginResponseStream() => _loginResponse.stream;

  setSelected(int value) {
    _selected = value;
    notifyListeners();
  }

  setIsLogging(bool value) {
    _isLogging = value;
    notifyListeners();
  }

  bool isValidData() {
    return phoneController.text.isNotEmpty &&
        Validations.isMobileNumberValid(phoneController.text.trim()) &&
        passwordController.text.isNotEmpty;
  }

  login() {
    setIsLogging(true);
    SignInRequest request = SignInRequest(
        phoneNumber: phoneController.text.trim(),
        password: passwordController.text.trim());
    ApiClient().login(request).then((loginResponse) {
      if(loginResponse.success){
        preferenceData.setToken(loginResponse.token!);
        preferenceData.setUserRole(loginResponse.role!);
      }
      _loginResponse.sink.add(loginResponse);
    });
  }
}
