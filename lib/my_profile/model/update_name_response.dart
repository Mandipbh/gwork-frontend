class UpdateNameModel {
  String? name;

  UpdateNameModel({
    this.name,
  });

  UpdateNameModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    return data;
  }
}
