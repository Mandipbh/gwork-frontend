class VerifyPhoneNumberOtpModel {
  String? otp;

  VerifyPhoneNumberOtpModel({
    this.otp,
  });

  VerifyPhoneNumberOtpModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['otp'] = otp;
    return data;
  }
}
