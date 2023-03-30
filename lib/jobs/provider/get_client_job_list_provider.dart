import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/model/get_client_job_list_response.dart';
import 'package:g_worker_app/jobs/model/get_job_details_client_model.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:provider/provider.dart';

import '../model/get_client_job_applications_model.dart';
import 'get_professional_job_list_provider.dart';

class GetClientJobListProvider extends ChangeNotifier {
  GetClientJobListModel? _model;
  GetClientJobListModel? get model => _model;

  GetClientJobOverviewModel? _detailsModel;
  GetClientJobOverviewModel? get detailsModel => _detailsModel;

  GetClientApplicationsModel? _applicationsModel;
  GetClientApplicationsModel? get applicationsModel => _applicationsModel;

  bool _isLogging = true;

  bool getIsLogging() => _isLogging;

  setIsLogging(bool value) {
    _isLogging = value;
    notifyListeners();
  }

  getDetailsClient(BuildContext context, String? jobId) {
    setIsLogging(true);

    ApiClient().getClientJobDetailsService(context, jobId!).then((value) {
      if (value.success!) {
        _detailsModel = value;

        setIsLogging(false);
        notifyListeners();
      }
    });
    //notifyListeners();
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

  getApplicantsForClient(BuildContext context, String? jobId) async {
    setIsLogging(true);

    ApiClient().getClientApplications(context, jobId!).then((value) {
      if (value!.success!) {
        _applicationsModel = value;

        setIsLogging(false);
        notifyListeners();
      }
    });
  }

  clearDataModel(BuildContext context) {
    _detailsModel = null;
    _applicationsModel = null;
  }
}
