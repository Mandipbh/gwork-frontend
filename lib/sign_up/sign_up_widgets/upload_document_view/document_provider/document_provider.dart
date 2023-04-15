import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class DocumentPicProvider extends ChangeNotifier {
  final List<String> _docList = ["add"];
  List<String> get docList => _docList;

  getDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;
      _docList.add(file.path!);
      // _docPath = file.path!;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);

      notifyListeners();
    } else {
      //TODO Error
      // User canceled the picker
    }

    notifyListeners();
  }

  String _imagePath = "";
  String get imagePath => _imagePath;

  getImage(source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);
    _imagePath = image!.path;
    _docList.add(_imagePath);
    notifyListeners();
  }

  clearDocument() {
    _docList.clear();
    _docList.add('add');
    notifyListeners();
  }
}
