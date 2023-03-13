class UpdateEmailModel {
  String? email;

  UpdateEmailModel({
    this.email,
  });

  UpdateEmailModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    return data;
  }
}
