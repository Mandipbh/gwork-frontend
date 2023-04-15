import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/model/get_prof_job_details_model.dart';
import 'package:g_worker_app/jobs/model/get_professional_job_response.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:g_worker_app/success_model/success_model_response.dart';
import '../../Constants.dart';
import '../model/job_status_update_response.dart';

class GetProfessionalJobListProvider extends ChangeNotifier {
  GetProfessionalJobListModel? _model;

  GetProfessionalJobListModel? get model => _model;

  GetProfJobDetailsModel? _detailsModel;

  GetProfJobDetailsModel? get detailsModel => _detailsModel;

  GetGalleryDetailsModel? _galleryDetailsModel;

  GetGalleryDetailsModel? get galleryDetailsModel => _galleryDetailsModel;

  List<Gallery> _currentJobGallery = [];
  List<Gallery> get currentJobGallery => _currentJobGallery;
  List<Gallery> professionalGallery = [];

  List<String> oddList = [];
  List<String> evenList = [];

  bool _isListLoading = true;
  bool _isOverviewLoading = true;
  bool _isGalleryLoading = true;
  bool _isApplicationsLoading = true;

  bool _isSelf = false;
  String _selectedProvince = "All";
  String _selectedState = JobsFilters.all;
  String _selectedCategory = JobsType.all;

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

  bool getIsSelf() => _isSelf;

  setIsSelf(bool value) {
    _isSelf = value;
    notifyListeners();
  }

  String getSelectedProvince() => _selectedProvince;

  setSelectedProvince(String value) {
    _selectedProvince = value;
    notifyListeners();
  }

  String getSelectedState() => _selectedState;

  setSelectedState(String value) {
    _selectedState = value;
    notifyListeners();
  }

  String getSelectedCategory() => _selectedCategory;

  setSelectedCategory(String value) {
    _selectedCategory = value;
    notifyListeners();
  }

  List<Gallery> getCurrentJobGallery() => _currentJobGallery;

  setCurrentJobGallery(List<Gallery> data) {
    _currentJobGallery = data;
    for (int i = 0; i < _currentJobGallery.length; i++) {
      professionalGallery.add(_currentJobGallery[i]);
    }
    notifyListeners();
  }

  getProfessionalJobList(
      {required String category,
      required String province,
      required bool isSelf,
      required BuildContext context,
      required String state,
      required String jobState}) {
    if (!_isListLoading) {
      setIsListLoading(true);
    }
    ApiClient()
        .getProfessionalJobListService(
            context: context,
            category: category,
            province: province,
            isSelf: isSelf,
            state: state,
            jobState: jobState)
        .then((value) {
      _model = value;
      setIsListLoading(false);
    });
  }

  getDetailsProfessional(BuildContext context, String? jobId) {
    if (!_isOverviewLoading) {
      setIsOverviewLoading(true);
    }
    ApiClient().getProfessionalJobDetailsService(context, jobId!).then((value) {
      if (value.success!) {
        _detailsModel = value;
        setIsOverviewLoading(false);
      }
    });
  }

  getGallery(BuildContext context, String? jobId) {
    if (!_isGalleryLoading) {
      setIsGalleryLoading(true);
    }
    ApiClient()
        .getGalleryDetailsService(context, jobId!)
        .then((getGallerySuccessResponse) {
      if (getGallerySuccessResponse.success!) {
        log("Images => ${getGallerySuccessResponse.gallery!.length}");
        // _galleryDetailsModel = value;
        //
        // for (int i = 0; i < value.gallery!.length; i++) {
        //   if (i % 2 == 0) {
        //     oddList.add(value.gallery![i].mediaUrl!);
        //   }
        // }
        // for (int i = 0; i < value.gallery!.length; i++) {
        //   if (i % 2 == 1) {
        //     evenList.add(value.gallery![i].mediaUrl!);
        //   }
        // }
        setCurrentJobGallery(getGallerySuccessResponse.gallery!);

        setIsGalleryLoading(false);
      }
    });
    //notifyListeners();
  }

  clearDataModel() {
    _galleryDetailsModel = null;
    _detailsModel = null;
    _isOverviewLoading = true;
    _isGalleryLoading = true;
    _isApplicationsLoading = true;
    _currentJobGallery = [];
    oddList = [];
    evenList = [];
  }

  Future<JobStatusUpdateResponse?> startJob(
      {required BuildContext context, required String jobId}) {
    return ApiClient().startJobAPI(jobId: jobId, context: context);
  }

  Future<JobStatusUpdateResponse?> completeJob(
      {required BuildContext context, required String jobId}) {
    return ApiClient().completeJobAPI(jobId: jobId, context: context);
  }

  Future<JobStatusUpdateResponse?> rejectJobs(
      {required BuildContext context, required String jobId}) {
    return ApiClient().rejectJobProf(jobId: jobId, context: context);
  }

  Future<SuccessDataModel?> applyJob(
      {required BuildContext context,
      required int price,
      required String jobId}) {
    return ApiClient().applyForJobProfessional(jobId, price, context);
  }
}
