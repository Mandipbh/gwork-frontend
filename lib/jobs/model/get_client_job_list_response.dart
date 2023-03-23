class GetClientJobListModel {
  GetClientJobListModel({
    required this.success,
    required this.jobs,
  });
  late final bool success;
  late final List<Jobs> jobs;

  GetClientJobListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    jobs = List.from(json['jobs']).map((e) => Jobs.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['jobs'] = jobs.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Jobs {
  Jobs({
    required this.id,
    required this.title,
    required this.state,
    required this.street,
    required this.province,
    required this.description,
    required this.budget,
    required this.category,
    required this.clientNotify,
    required this.jobApplicationCount,
    required this.jobDate,
    required this.creationDate,
  });
  late final String id;
  late final String title;
  late final String state;
  late final String street;
  late final String province;
  late final String description;
  late final int budget;
  late final String category;
  late final int clientNotify;
  late final int jobApplicationCount;
  late final String jobDate;
  late final String creationDate;

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    state = json['state'];
    street = json['street'];
    province = json['province'];
    description = json['description'];
    budget = json['budget'];
    category = json['category'];
    clientNotify = json['client_notify'];
    jobApplicationCount = json['job_application_count'];
    jobDate = json['job_date'];
    creationDate = json['creation_date'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['state'] = state;
    _data['street'] = street;
    _data['province'] = province;
    _data['description'] = description;
    _data['budget'] = budget;
    _data['category'] = category;
    _data['client_notify'] = clientNotify;
    _data['job_application_count'] = jobApplicationCount;
    _data['job_date'] = jobDate;
    _data['creation_date'] = creationDate;
    return _data;
  }
}
