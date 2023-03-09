import 'package:flutter/cupertino.dart';
import 'package:g_worker_app/Constants.dart';

class SignInProvider extends ChangeNotifier {
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  int _selected = SelectionType.signIn;

  int getSelected() => _selected;

  setSelected(int value) {
    _selected = value;
    notifyListeners();
  }

  bool isValidData() {
    return phoneController.text.isNotEmpty && passwordController.text.isNotEmpty;
  }
}
