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

  bool _isListLoading = true;
  bool _isOverviewLoading = true;
  bool _isGalleryLoading = true;
  bool _isApplicationsLoading = true;
  bool _isAccepted = false;

  String _selectedFilter = JobsFilters.all;
  String _selectedJobType = JobsType.all;

  bool getIsListLoading() => _isListLoading;

  setIsListLoading(bool value) {
    _isListLoading = value;
    notifyListeners();
  }

  bool getIsOverviewLoading() => _isOverviewLoading;

  setIsOverviewLoading(bool value) {
    _isOverviewLoading = value;
    notifyListeners();
  }

  bool getIsGalleryLoading() => _isGalleryLoading;

  setIsGalleryLoading(bool value) {
    _isGalleryLoading = value;
    notifyListeners();
  }

  bool getIsApplicationsLoading() => _isApplicationsLoading;

  setIsApplicationsLoading(bool value) {
    _isApplicationsLoading = value;
    notifyListeners();
  }

  bool getIsAccepted() => _isAccepted;

  setIsAccepted(bool value) {
    _isAccepted = value;
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

  getDetailsClient(BuildContext context, String? jobId) {
    if (!_isOverviewLoading) {
      setIsOverviewLoading(true);
    }
    ApiClient().getClientJobDetailsService(context, jobId!).then((value) {
      if (value.success!) {
        _detailsModel = value;
        setIsOverviewLoading(false);
        notifyListeners();
      }
    });
  }

  getClientJobList(String state, String category, BuildContext context) {
    if (!_isListLoading) {
      setIsListLoading(true);
    }
    ApiClient().getClientJobService(context, state, category).then((value) {
      _model = value;
      setIsListLoading(false);
      notifyListeners();
    });
  }

  getApplicantsForClient(BuildContext context, String? jobId) async {
    ApiClient().getClientApplications(context, jobId!).then((value) {
      if (value!.success!) {
        _applicationsModel = value;
        setIsApplicationsLoading(false);
        notifyListeners();
      }
    });
  }

  clearDataModel(BuildContext context) {
    _detailsModel = null;
    _applicationsModel = null;
    _isOverviewLoading = true;
    _isGalleryLoading = true;
    _isApplicationsLoading = true;
  }

  Future<JobStatusUpdateResponse?> updateJobStatus(
      {required int status,
      required BuildContext context,
      required String jobId}) {
    return ApiClient()
        .approveOrRejectJob(jobId: jobId, jobState: status, context: context);
  }

  Future<JobStatusUpdateResponse?> deleteJob(
      {required BuildContext context, required String jobId}) {
    return ApiClient().deleteJobAPI(jobId: jobId, context: context);
  }

  Future<JobStatusUpdateResponse?> acceptJob(
    String jobId,
    String userId,
    BuildContext context,
  ) {
    return ApiClient()
        .acceptJobAPI(jobId: jobId, userId: userId, context: context);
  }
}
