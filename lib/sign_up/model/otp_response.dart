class OtpModel {
  bool? success;
  String? otp;

  OtpModel({
    this.success,
    this.otp,
  });

  OtpModel.fromJson(Map<String, dynamic> json) {
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
