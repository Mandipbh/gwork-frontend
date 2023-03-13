class UpdateLastNameModel {
  String? lastName;

  UpdateLastNameModel({
    this.lastName,
  });

  UpdateLastNameModel.fromJson(Map<String, dynamic> json) {
    lastName = json['surname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['surname'] = lastName;
    return data;
  }
}
