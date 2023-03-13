class UpdatePhoneNumberModel {
  String? credentialToken;
  String? phoneNumber;

  UpdatePhoneNumberModel({
    this.credentialToken,
    this.phoneNumber,
  });

  UpdatePhoneNumberModel.fromJson(Map<String, dynamic> json) {
    credentialToken = json['credentials_token'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['credentials_token'] = credentialToken;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
