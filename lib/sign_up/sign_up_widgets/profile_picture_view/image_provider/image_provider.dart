import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/common_widgets.dart';

class ProfilePicProvider extends ChangeNotifier {
  String _imagePath = "";
  String get imagePath => _imagePath;

  String? _getImageString;
  String? get getImageString => _getImageString;
  Future<bool> getImage(source, context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image =
          await _picker.pickImage(source: source, imageQuality: 50);
      _imagePath = image!.path;
      _getImageString = await upLoadImage(
        File(_imagePath),
      );

      notifyListeners();
      return true;
    } catch (e) {
      ErrorLoader(context, tr("error_message.no_image_selected"));
      notifyListeners();
      return false;
    }
  }

  clearImage() {
    _imagePath = "";
    notifyListeners();
  }
}
