class OtpVerifyModel {
  bool? success;
  String? token;

  OtpVerifyModel({
    this.success,
    this.token,
  });

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
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
