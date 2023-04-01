import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/model/get_client_job_list_response.dart';
import 'package:g_worker_app/jobs/model/get_prof_job_details_model.dart';
import 'package:g_worker_app/jobs/model/get_professional_job_response.dart';
import 'package:g_worker_app/server_connection/api_client.dart';

import '../../Constants.dart';

class GetProfessionalJobListProvider extends ChangeNotifier {
  GetProfessionalJobListModel? _model;

  GetProfessionalJobListModel? get model => _model;

  GetProfJobDetailsModel? _detailsModel;

  GetProfJobDetailsModel? get detailsModel => _detailsModel;

  GetGalleryDetailsModel? _galleryDetailsModel;

  GetGalleryDetailsModel? get galleryDetailsModel => _galleryDetailsModel;

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
    ApiClient().getGalleryDetailsService(context, jobId!).then((value) {
      if (value.success!) {
        _galleryDetailsModel = value;

        for (int i = 0; i < value.gallery!.length; i++) {
          if (i % 2 == 0) {
            oddList.add(value.gallery![i].mediaUrl!);
          }
        }
        for (int i = 0; i < value.gallery!.length; i++) {
          if (i % 2 == 1) {
            evenList.add(value.gallery![i].mediaUrl!);
          }
        }
        setIsGalleryLoading(false);
      }
    });
    //notifyListeners();
  }

  clearProvider() {
    _model = null;
  }

  clearDataModel() {
    _galleryDetailsModel = null;
    _detailsModel = null;
    oddList = [];
    evenList = [];
  }
}
