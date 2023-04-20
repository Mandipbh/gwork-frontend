class GetClientJobOverviewModel {
  bool? success;
  JobDetails? jobDetails;

  GetClientJobOverviewModel({this.success, this.jobDetails});

  GetClientJobOverviewModel.fromJson(Map<String, dynamic> json) {
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
  String? dateTime;
  int? budget;
  String? state;
  int? clientApprove;
  int? adminApprove;
  int? invoiceGenerated;
  Null? invoiceUrl;
  String? createdAt;
  String? jobDate;
  String? creationDate;
  String? clientName;
  String? clientImage;
  String? professionalName;
  String? professionalImage;
  String? role;
  int? gallery;
  int? applicationCount;
  String? applicationState;
  int? chatCount;
  String? applicationAccepted;
  int? acceptedBudget;

  JobDetails({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.category,
    this.street,
    this.commune,
    this.province,
    this.date,
    this.time,
    this.dateTime,
    this.budget,
    this.state,
    this.clientApprove,
    this.adminApprove,
    this.invoiceGenerated,
    this.invoiceUrl,
    this.createdAt,
    this.jobDate,
    this.creationDate,
    this.clientName,
    this.clientImage,
    this.professionalName,
    this.professionalImage,
    this.role,
    this.gallery,
    this.applicationCount,
    this.applicationState,
    this.chatCount,
    this.applicationAccepted,
    this.acceptedBudget,
  });

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
    dateTime = json['date_time'];
    budget = json['budget'];
    state = json['state'];
    clientApprove = json['client_approve'];
    adminApprove = json['admin_approve'];
    invoiceGenerated = json['invoice_generated'];
    invoiceUrl = json['invoice_url'];
    createdAt = json['created_at'];
    jobDate = json['job_date'];
    creationDate = json['creation_date'];
    clientName = json['client_name'];
    clientImage = json['client_image'];
    professionalName = json['professional_name'];
    professionalImage = json['professional_image'];
    role = json['role'];
    gallery = json['gallery'];
    applicationCount = json['application_count'];
    applicationState = json['application_state'];
    chatCount = json['chat_count'];
    applicationAccepted = json['application_accepted'];
    acceptedBudget = json['accepted_budget'];
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
    data['date_time'] = this.dateTime;
    data['budget'] = this.budget;
    data['state'] = this.state;
    data['client_approve'] = this.clientApprove;
    data['admin_approve'] = this.adminApprove;
    data['invoice_generated'] = this.invoiceGenerated;
    data['invoice_url'] = this.invoiceUrl;
    data['created_at'] = this.createdAt;
    data['job_date'] = this.jobDate;
    data['creation_date'] = this.creationDate;
    data['client_name'] = this.clientName;
    data['client_image'] = this.clientImage;
    data['professional_name'] = this.professionalName;
    data['professional_image'] = this.professionalImage;
    data['role'] = this.role;
    data['gallery'] = this.gallery;
    data['application_count'] = this.applicationCount;
    data['application_state'] = this.applicationState;
    data['chat_count'] = this.chatCount;
    data['application_accepted'] = this.applicationAccepted;
    data['accepted_budget'] = this.acceptedBudget;
    return data;
  }
}
