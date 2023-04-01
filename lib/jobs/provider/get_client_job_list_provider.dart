import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/model/get_client_job_list_response.dart';
import 'package:g_worker_app/jobs/model/get_job_details_client_model.dart';
import 'package:g_worker_app/jobs/model/job_status_update_response.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:provider/provider.dart';

import '../../Constants.dart';
import '../model/get_client_job_applications_model.dart';
import 'get_professional_job_list_provider.dart';

class GetClientJobListProvider extends ChangeNotifier {
  GetClientJobListModel? _model;

  GetClientJobListModel? get model => _model;

  GetClientJobOverviewModel? _detailsModel;

  GetClientJobOverviewModel? get detailsModel => _detailsModel;

  GetClientApplicationsModel? _applicationsModel;

  GetClientApplicationsModel? get applicationsModel => _applicationsModel;

  bool _isLoading = true;
  bool _isJobStatusUpdating = true;

  String _selectedFilter = JobsFilters.all;
  String _selectedJobType = JobsType.all;

  bool getIsLoading() => _isLoading;

  setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String getSelectedFilter() => _selectedFilter;

  setSelectedFilter(String value) {
    _selectedFilter = value;
    notifyListeners();
  }

  String getSelectedJobType() => _selectedJobType;

  setSelectedJobType(String value) {
    _selectedJobType = value;
    notifyListeners();
  }

  bool getIsJobStatusUpdating() => _isJobStatusUpdating;

  setIsJobStatusUpdating(bool value) {
    _isJobStatusUpdating = value;
    notifyListeners();
  }

  getDetailsClient(BuildContext context, String? jobId) {
    if (!getIsLoading()) {
      setIsLoading(true);
    }
    ApiClient().getClientJobDetailsService(context, jobId!).then((value) {
      if (value.success!) {
        _detailsModel = value;
        setIsLoading(false);
        notifyListeners();
      }
    });
  }

  getData(String state, String category, BuildContext context) {
    if (!getIsLoading()) {
      setIsLoading(true);
    }
    ApiClient().getClientJobService(context, state, category).then((value) {
      _model = value;
      setIsLoading(false);
      notifyListeners();
    });
  }

  getApplicantsForClient(BuildContext context, String? jobId) async {
    if (!getIsLoading()) {
      setIsLoading(true);
    }
    ApiClient().getClientApplications(context, jobId!).then((value) {
      if (value!.success!) {
        _applicationsModel = value;
        setIsLoading(false);
        notifyListeners();
      }
    });
  }

  clearDataModel(BuildContext context) {
    _detailsModel = null;
    _applicationsModel = null;
  }

  void updateJobStatus(
      {required int status,
      required BuildContext context,
      required String jobId}) {
    setIsJobStatusUpdating(true);
    ApiClient()
        .approveOrRejectJob(jobId: jobId, jobState: status, context: context)
        .then((value) {
      if (value!.success!) {
        setIsJobStatusUpdating(false);
      }
    });
  }

  Future<JobStatusUpdateResponse?> deleteJob(
      {required BuildContext context, required String jobId}) {
    return ApiClient().deleteJobAPI(jobId: jobId, context: context);
  }

  void startJob({required BuildContext context, required String jobId}) {
    setIsJobStatusUpdating(true);
    ApiClient().startJobAPI(jobId: jobId, context: context).then((value) {
      if (value!.success!) {
        setIsJobStatusUpdating(false);
      }
    });
  }

  void completeJob({required BuildContext context, required String jobId}) {
    setIsJobStatusUpdating(true);
    ApiClient().completeJobAPI(jobId: jobId, context: context).then((value) {
      if (value!.success!) {
        setIsJobStatusUpdating(false);
      }
    });
  }

  void acceptJob(
      {required String userId,
      required BuildContext context,
      required String jobId}) {
    setIsJobStatusUpdating(true);
    ApiClient()
        .acceptJobAPI(jobId: jobId, userId: userId, context: context)
        .then((value) {
      if (value!.success!) {
        setIsJobStatusUpdating(false);
      }
    });
  }
}
