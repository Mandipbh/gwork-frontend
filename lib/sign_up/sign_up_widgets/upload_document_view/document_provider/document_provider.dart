import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DocumentPicProvider extends ChangeNotifier {
  List<String> _docList = ["add"];
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

  clearImage() {
    _docList.clear();
    notifyListeners();
  }
}
