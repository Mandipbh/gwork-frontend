class UpdatePasswordModel {
  String? oldPassword;
  String? newPassword;

  UpdatePasswordModel({
    this.oldPassword,
    this.newPassword,
  });

  UpdatePasswordModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['old_password'];
    newPassword = json['new_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['old_password'] = oldPassword;
    data['new_password'] = newPassword;
    return data;
  }
}
