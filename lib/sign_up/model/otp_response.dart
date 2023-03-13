class OtpModel {
  String? phoneNumber;

  OtpModel({
    this.phoneNumber,
  });

  OtpModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone_number'] = phoneNumber;
    return data;
  }
}
