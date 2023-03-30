class GetClientApplicationsModel {
  bool? success;
  List<Applications>? applications;

  GetClientApplicationsModel({this.success, this.applications});

  GetClientApplicationsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['applications'] != null) {
      applications = <Applications>[];
      json['applications'].forEach((v) {
        applications!.add(new Applications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.applications != null) {
      data['applications'] = this.applications!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Applications {
  String? professionalName;
  String? professionalImage;
  int? price;
  String? professionalId;
  int? chatCount;

  Applications(
      {this.professionalName,
      this.professionalImage,
      this.price,
      this.professionalId,
      this.chatCount});

  Applications.fromJson(Map<String, dynamic> json) {
    professionalName = json['professional_name'];
    professionalImage = json['professional_image'];
    price = json['price'];
    professionalId = json['professional_id'];
    chatCount = json['chat_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['professional_name'] = this.professionalName;
    data['professional_image'] = this.professionalImage;
    data['price'] = this.price;
    data['professional_id'] = this.professionalId;
    data['chat_count'] = this.chatCount;
    return data;
  }
}
