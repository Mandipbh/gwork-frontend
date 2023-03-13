class CheckEmailModel {
  String? email;

  CheckEmailModel({
    this.email,
  });

  CheckEmailModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    return data;
  }
}
