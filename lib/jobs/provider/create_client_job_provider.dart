import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:g_worker_app/Constants.dart';
import 'package:g_worker_app/common/common_loader.dart';
import 'package:g_worker_app/jobs/add_job_widgets/upload_images_view.dart';
import 'package:g_worker_app/server_connection/api_client.dart';
import 'package:provider/provider.dart';

import '../../sign_up/provider/sign_up_provider.dart';
import 'get_client_job_list_provider.dart';

class CreateClientJobProvider extends ChangeNotifier {
  String _category = JobsType.cleaning;
  String? _title;
  String? _street;
  String? _province;
  String? _comune;
  String? _date;
  String? _time;
  String? _description;
  String? _budget;

  String? get category => _category;
  String? get title => _title;
  String? get street => _street;
  String? get province => _province;
  String? get comune => _comune;
  String? get date => _date;
  String? get time => _time;
  String? get description => _description;
  String? get budget => _budget;

  bool _isLoading = false;
  bool getIsLoading() => _isLoading;
  setIsLoading(bool value) {
    _isLoading = value;
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
  DateTime? _pickedDateUtc;
  DateTime? get pickedDateUtc => _pickedDateUtc;

  setJobInfo(BuildContext context) {
    if (titleController.text.isEmpty ||
        streetController.text.isEmpty ||
        comuneController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
      return false;
    } else {
      _title = titleController.text;
      _street = streetController.text;
      _comune = comuneController.text;
      notifyListeners();
      return true;
    }
  }

  setDatePicked(val) {
    _pickedDateUtc = val;
    notifyListeners();
  }

  //Schedule
  var dateController = TextEditingController();
  var timeController = TextEditingController();

  setSchedule(BuildContext context) {
    if (dateController.text.isEmpty || timeController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
      return false;
    } else if (_pickedDateUtc!.millisecondsSinceEpoch >
        DateTime.now().millisecondsSinceEpoch) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
      return false;
    } else {
      _date = dateController.text;
      _time = timeController.text;
      notifyListeners();
      return true;
    }
  }

  // More Info

  var describeController = TextEditingController();
  var budgetController = TextEditingController();

  setMoreInfo(BuildContext context) {
    if (describeController.text.isEmpty || budgetController.text.isEmpty) {
      ErrorLoader(context, tr("error_message.fill_all_data"));
      notifyListeners();
      return false;
    } else {
      _description = describeController.text;
      _budget = budgetController.text;
      notifyListeners();
      return true;
    }
  }

  createJobClient(BuildContext context) {
    if (!_isLoading) {
      setIsLoading(true);
    }
    ApiClient()
        .createClientJob('$category', title!, street!, comune!, date!, time!,
            description!, budget!, context)
        .then((updateCreateClientJobSuccessResponse) {
      if (updateCreateClientJobSuccessResponse.success!) {
        Provider.of<GetClientJobListProvider>(context, listen: false)
            .getClientJobList("All", "All", context);
        clearCreateJobProvider(context);
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        ProgressLoader(context, tr("success_message.job_create_success"));
        notifyListeners();
        return true;
      }
    });
  }

  clearCreateJobProvider(BuildContext context) {
    titleController.clear();
    streetController.clear();
    comuneController.clear();
    dateController.clear();
    timeController.clear();
    describeController.clear();
    budgetController.clear();
    Provider.of<UploadImageProvider>(context, listen: false).clearImage();

    Provider.of<SignUpProvider>(context, listen: false).updateProvinceValue(
        Provider.of<SignUpProvider>(context, listen: false)
            .proviceModel!
            .provice[0]);
    notifyListeners();
  }
}
