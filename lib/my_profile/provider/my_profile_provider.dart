import 'package:flutter/cupertino.dart';
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
    notifyListeners();
  }

  clearProfileProvider() {
    _model = null;
    notifyListeners();
  }
}
