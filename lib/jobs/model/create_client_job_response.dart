class CreateClientJobModel {
  CreateClientJobModel({
    this.success,
    this.id,
  });
  bool? success;
  String? id;

  CreateClientJobModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['id'] = id;
    return _data;
  }
}
