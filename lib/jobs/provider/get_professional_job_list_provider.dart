import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/model/get_client_job_list_response.dart';
import 'package:g_worker_app/jobs/model/get_prof_job_details_model.dart';
import 'package:g_worker_app/jobs/model/get_professional_job_response.dart';
import 'package:g_worker_app/server_connection/api_client.dart';

class GetProfessionalJobListProvider extends ChangeNotifier {
  GetProfessionalJobListModel? _model;

  GetProfessionalJobListModel? get model => _model;

  GetProfJobDetailsModel? _detailsModel;

  GetProfJobDetailsModel? get detailsModel => _detailsModel;

  GetGalleryDetailsModel? _galleryDetailsModel;

  GetGalleryDetailsModel? get galleryDetailsModel => _galleryDetailsModel;

  List<String> oddList = [];
  List<String> evenList = [];

  bool _isLogging = true;

  bool getIsLogging() => _isLogging;

  setIsLogging(bool value) {
    _isLogging = value;
    notifyListeners();
  }

  getDataProfessional(
      {required String category,
      required String province,
      required bool isSelf,
      required BuildContext context,
      required String state,
      required String jobState}) {
    if (!_isLogging) {
      setIsLogging(true);
    }
    _model = null;
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

      setIsLogging(false);
      notifyListeners();
    });
    //notifyListeners();
  }

  getDetailsProfessional(BuildContext context, String? jobId) {
    setIsLogging(true);

    ApiClient().getProfessionalJobDetailsService(context, jobId!).then((value) {
      if (value.success!) {
        _detailsModel = value;

        setIsLogging(false);
        notifyListeners();
      }
    });
    //notifyListeners();
  }

  getGallery(BuildContext context, String? jobId) {
    setIsLogging(true);

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

        setIsLogging(false);
        notifyListeners();
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
