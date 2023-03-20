class RequestOtpModel {
  bool? success;
  String? otp;

  RequestOtpModel({
    this.success,
    this.otp,
  });

  RequestOtpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['otp'] = otp;
    return data;
  }
}
