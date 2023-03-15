class VerifyOtpModel {
  bool? success;
  String? error;

  VerifyOtpModel({
    this.success,
    this.error,
  });

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['error'] = error;
    return data;
  }
}
