class GetProfJobDetailsModel {
  bool? success;
  JobDetails? jobDetails;

  GetProfJobDetailsModel({this.success, this.jobDetails});

  GetProfJobDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    jobDetails = json['jobDetails'] != null
        ? new JobDetails.fromJson(json['jobDetails'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.jobDetails != null) {
      data['jobDetails'] = this.jobDetails!.toJson();
    }
    return data;
  }
}

class JobDetails {
  String? id;
  String? userId;
  String? title;
  String? description;
  String? category;
  String? street;
  String? commune;
  String? province;
  String? date;
  String? time;
  int? budget;
  String? state;
  String? jobDate;
  String? creationDate;
  String? clientName;
  String? clientImage;
  String? role;
  String? professionalName;
  String? professionalImage;
  String? professionalId;
  String? role2;
  int? acceptedBudget;
  int? gallery;
  String? applicationState;
  int? chatCount;

  JobDetails(
      {this.id,
      this.userId,
      this.title,
      this.description,
      this.category,
      this.street,
      this.commune,
      this.province,
      this.date,
      this.time,
      this.budget,
      this.state,
      this.jobDate,
      this.creationDate,
      this.clientName,
      this.clientImage,
      this.role,
      this.professionalName,
      this.professionalImage,
      this.professionalId,
      this.role2,
      this.acceptedBudget,
      this.gallery,
      this.applicationState,
      this.chatCount});

  JobDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    description = json['description'];
    category = json['category'];
    street = json['street'];
    commune = json['commune'];
    province = json['province'];
    date = json['date'];
    time = json['time'];
    budget = json['budget'];
    state = json['state'];
    jobDate = json['job_date'];
    creationDate = json['creation_date'];
    clientName = json['client_name'];
    clientImage = json['client_image'] ?? "";
    role = json['role'];
    professionalName = json['professional_name'];
    professionalImage = json['professional_image'];
    professionalId = json['professional_id'];
    role2 = json['role2'];
    acceptedBudget = json['accepted_budget'];
    gallery = json['gallery'];
    applicationState = json['application_state'];
    chatCount = json['chat_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['category'] = this.category;
    data['street'] = this.street;
    data['commune'] = this.commune;
    data['province'] = this.province;
    data['date'] = this.date;
    data['time'] = this.time;
    data['budget'] = this.budget;
    data['state'] = this.state;
    data['job_date'] = this.jobDate;
    data['creation_date'] = this.creationDate;
    data['client_name'] = this.clientName;
    data['client_image'] = this.clientImage;
    data['role'] = this.role;
    data['professional_name'] = this.professionalName;
    data['professional_image'] = this.professionalImage;
    data['professional_id'] = this.professionalId;
    data['role2'] = this.role2;
    data['accepted_budget'] = this.acceptedBudget;
    data['gallery'] = this.gallery;
    data['application_state'] = this.applicationState;
    data['chat_count'] = this.chatCount;
    return data;
  }
}

class GetGalleryDetailsModel {
  bool? success;
  List<Gallery>? gallery;

  GetGalleryDetailsModel({this.success, this.gallery});

  GetGalleryDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['gallery'] != null) {
      gallery = <Gallery>[];
      json['gallery'].forEach((v) {
        gallery!.add(new Gallery.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.gallery != null) {
      data['gallery'] = this.gallery!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Gallery {
  String? mediaUrl;
  String? mediaName;

  Gallery({this.mediaUrl, this.mediaName});

  Gallery.fromJson(Map<String, dynamic> json) {
    mediaUrl = json['media_url'];
    mediaName = json['media_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['media_url'] = this.mediaUrl;
    data['media_name'] = this.mediaName;
    return data;
  }
}
