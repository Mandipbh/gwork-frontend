class SuccessDataModel {
  bool? success;

  SuccessDataModel({
    this.success,
  });

  SuccessDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = success;
    return data;
  }
}
