class RequestChangePhoneModel {
  bool? success;
  String? otp;

  RequestChangePhoneModel({
    this.success,
    this.otp,
  });

  RequestChangePhoneModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    otp = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    data['code'] = otp;
    return data;
  }
}
