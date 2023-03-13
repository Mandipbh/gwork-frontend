class VerifyOtpModel {
  String? phoneNumber;
  String? otp;

  VerifyOtpModel({
    this.phoneNumber,
    this.otp,
  });

  VerifyOtpModel.fromJson(Map<String, dynamic> json) {
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
