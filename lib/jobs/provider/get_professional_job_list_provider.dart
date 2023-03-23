import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:g_worker_app/jobs/model/get_client_job_list_response.dart';
import 'package:g_worker_app/jobs/model/get_professional_job_response.dart';
import 'package:g_worker_app/server_connection/api_client.dart';

class GetProfessionalJobListProvider extends ChangeNotifier {
  GetProfessionalJobListModel? _model;
  GetProfessionalJobListModel? get model => _model;

  // List<Jobs>? _babySitting = [];
  // List<Jobs>? get babySitting => _babySitting;
  //
  // List<Jobs>? _cleaning = [];
  // List<Jobs>? get cleaning => _cleaning;
  //
  // List<Jobs>? _handyMan = [];
  // List<Jobs>? get handyMan => _handyMan;
  //
  // List<Jobs>? _tutoring = [];
  // List<Jobs>? get tutoring => _tutoring;

  bool _isLogging = false;

  bool getIsLogging() => _isLogging;

  setIsLogging(bool value) {
    _isLogging = value;
    //notifyListeners();
  }

  getDataProfessional(String category,String province,bool isSelf, BuildContext context) {
    setIsLogging(true);
    ApiClient().getProfessionalJobListService(context, category, province,isSelf).then((value) {
      _model = value;
      // for (var element in _model!.jobs) {
      //   if (element.category == 'Babysitting') {
      //     _babySitting!.add(element);
      //   }
      //   if (element.category == 'Cleaning') {
      //     _cleaning!.add(element);
      //   }
      //   if (element.category == 'Handyman') {
      //     _handyMan!.add(element);
      //   }
      //   if (element.category == 'Tutoring') {
      //     _tutoring!.add(element);
      //   }
      // }

      setIsLogging(false);
      notifyListeners();
    });
    //notifyListeners();
  }
}
