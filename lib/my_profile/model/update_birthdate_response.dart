class UpdateBirthDateModel {
  String? birthDate;

  UpdateBirthDateModel({
    this.birthDate,
  });

  UpdateBirthDateModel.fromJson(Map<String, dynamic> json) {
    birthDate = json['birth_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['birth_date'] = birthDate;
    return data;
  }
}
