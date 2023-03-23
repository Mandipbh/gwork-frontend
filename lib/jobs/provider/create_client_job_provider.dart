import 'package:flutter/cupertino.dart';
import 'package:g_worker_app/common/common_loader.dart';

class CreateClientJobProvider extends ChangeNotifier {
  int? _category;
  String? _title;
  String? _street;
  String? _province;
  String? _comune;
  String? _date;
  String? _time;
  String? _description;
  String? _budget;

  int? get category => _category;
  String? get title => _title;
  String? get street => _street;
  String? get province => _province;
  String? get comune => _comune;
  String? get date => _date;
  String? get time => _time;
  String? get description => _description;
  String? get budget => _budget;

  bool _isLogging = false;
  bool getIsLogging() => _isLogging;
  setIsLogging(bool value) {
    _isLogging = value;
    notifyListeners();
  }

  setCategory(value) {
    _category = value;
    notifyListeners();
  }

  // Job Info
  var titleController = TextEditingController();
  var streetController = TextEditingController();
  var comuneController = TextEditingController();

  setJobInfo(BuildContext context) {
    if (titleController.text.isEmpty ||
        streetController.text.isEmpty ||
        comuneController.text.isEmpty) {
      ErrorLoader(context, "Please fill all the details");
      notifyListeners();
      return false;
    } else {
      _title = title;
      _street = street;
      _comune = comune;
      notifyListeners();
      return true;
    }
  }

  //Schedule
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  setSchedule(BuildContext context) {
    if (dateController.text.isEmpty || timeController.text.isEmpty) {
      ErrorLoader(context, "Please fill all the details");
      notifyListeners();
      return false;
    } else {
      _date = date;
      _time = time;
      notifyListeners();
      return true;
    }
  }

  // More Info

  var describeController = TextEditingController();
  var budgetController = TextEditingController();

  setMoreInfo(BuildContext context) {
    if (describeController.text.isEmpty || budgetController.text.isEmpty) {
      ErrorLoader(context, "Please fill all the details");
      notifyListeners();
      return false;
    } else {
      _description = description;
      _time = time;
      notifyListeners();
      return true;
    }
  }
}
