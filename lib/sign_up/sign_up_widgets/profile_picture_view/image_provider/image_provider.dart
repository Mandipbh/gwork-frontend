import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicProvider extends ChangeNotifier {
  String _imagePath = "";
  String get imagePath => _imagePath;

  getImage(source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    _imagePath = image!.path;

    notifyListeners();
  }

  clearImage() {
    _imagePath = "";
    notifyListeners();
  }
}
