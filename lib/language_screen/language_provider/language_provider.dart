import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  int _selectedRadioTile = -1;
  int get selectedRadioTile => _selectedRadioTile;

  onGroupChange(val) {
    _selectedRadioTile = val;
    notifyListeners();
  }
}
