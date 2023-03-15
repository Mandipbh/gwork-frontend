import 'dart:io';

import 'package:flutter/material.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/common_widgets.dart';

class ProfilePicProvider extends ChangeNotifier {
  String _imagePath = "";
  String get imagePath => _imagePath;

  String? _getImageString;
  String? get getImageString => _getImageString;
  getImage(source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image =
        await _picker.pickImage(source: source, imageQuality: 50);
    _imagePath = image!.path;
    _getImageString = await upLoadImage(
      File(_imagePath),
    );
    notifyListeners();
  }

  clearImage() {
    _imagePath = "";
    notifyListeners();
  }
}
