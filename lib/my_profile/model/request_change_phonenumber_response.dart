class RequestChangePhoneNumberModel {
  String? phoneNumber;

  RequestChangePhoneNumberModel({
    this.phoneNumber,
  });

  RequestChangePhoneNumberModel.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['phone_number'] = phoneNumber;
    return data;
  }
}
