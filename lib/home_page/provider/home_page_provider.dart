import 'package:flutter/cupertino.dart';
import 'package:g_worker_app/shared_preference_data.dart';

class HomePageProvider extends ChangeNotifier{
  SharedPreferenceData preferenceData = SharedPreferenceData();

  Future<String> getToken() async{
    return await preferenceData.getToken();
  }

  Future<int> getUserRole() async{
    return await preferenceData.getUserRole();
  }
}