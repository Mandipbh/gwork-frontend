import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/model/get_job_list_response.dart';
import 'package:g_worker_app/server_connection/api_client.dart';

class GetClientJobListProvider extends ChangeNotifier {
  GetClientJobListModel? _model;
  GetClientJobListModel? get model => _model;

  bool _isLogging = false;

  bool getIsLogging() => _isLogging;

  setIsLogging(bool value) {
    _isLogging = value;
    notifyListeners();
  }

  getData(String state, String category, BuildContext context) {
    setIsLogging(true);
    ApiClient().getClientJobService(context, state, category).then((value) {
      _model = value;
      setIsLogging(false);
      notifyListeners();
    });
    //notifyListeners();
  }
}
