class RequestOtpModel {
  String? phoneNumber;

  RequestOtpModel({
    this.phoneNumber,
  });

  RequestOtpModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone_number'] = phoneNumber;
    return data;
  }
}
