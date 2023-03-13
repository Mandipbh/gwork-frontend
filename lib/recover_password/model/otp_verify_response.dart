class OtpVerifyModel {
  String? phoneNumber;
  String? otp;

  OtpVerifyModel({
    this.phoneNumber,
    this.otp,
  });

  OtpVerifyModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone_number'] = phoneNumber;
    data['otp'] = otp;
    return data;
  }
}
