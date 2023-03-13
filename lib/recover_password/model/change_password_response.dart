class ChangePasswordModel {
  String? token;
  String? password;

  ChangePasswordModel({
    this.token,
    this.password,
  });

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    data['password'] = password;
    return data;
  }
}
