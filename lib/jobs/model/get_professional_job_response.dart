class GetProfessionalJobListModel {
  GetProfessionalJobListModel({this.success, this.jobs, this.earning});
  bool? success;
  List<Jobs>? jobs;
  String? earning;

  GetProfessionalJobListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    earning = json['earning'];
    jobs = List.from(json['jobs']).map((e) => Jobs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['jobs'] = jobs;
    _data['earning'] = earning;
    return _data;
  }
}

class Jobs {
  Jobs(
      {this.id,
      this.title,
      this.state,
      this.description,
      this.street,
      this.province,
      this.budget,
      this.category,
      this.professionalNotify,
      this.creationDate,
      this.applicationState});
  String? id;
  String? title;
  String? state;
  String? description;
  String? street;
  String? province;
  int? budget;
  String? category;
  int? professionalNotify;
  String? creationDate;
  String? applicationState;

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    state = json['state'];
    description = json['description'];
    street = json['street'];
    province = json['province'];
    budget = json['budget'];
    category = json['category'];
    professionalNotify = json['professional_notify'];
    creationDate = json['creation_date'];
    applicationState = json['application_state'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['state'] = state;
    _data['description'] = description;
    _data['street'] = street;
    _data['province'] = province;
    _data['budget'] = budget;
    _data['category'] = category;
    _data['professional_notify'] = professionalNotify;
    _data['creation_date'] = creationDate;
    return _data;
  }
}
