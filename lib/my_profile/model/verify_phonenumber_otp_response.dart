class VerifyPhoneNumberOtpModel {
  bool? success;
  String? token;

  VerifyPhoneNumberOtpModel({
    this.success,
    this.token,
  });

  VerifyPhoneNumberOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['token'] = token;
    return data;
  }
}
