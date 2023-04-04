class Message {
  String? id;
  String? userId;
  String? jobId;
  String? chat;
  String? toUserId;
  int? clientNotify;
  int? professionalNotify;
  String? createdAt;
  int? isSelf;

  Message(
      {this.id,
      this.userId,
      this.jobId,
      this.chat,
      this.toUserId,
      this.clientNotify,
      this.professionalNotify,
      this.createdAt,
      this.isSelf});

  Message.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jobId = json['job_id'];
    chat = json['chat'];
    toUserId = json['to_user_id'];
    clientNotify = json['client_notify'];
    professionalNotify = json['professional_notify'];
    createdAt = json['created_at'];
    isSelf = json['is_self'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['job_id'] = this.jobId;
    data['chat'] = this.chat;
    data['to_user_id'] = this.toUserId;
    data['client_notify'] = this.clientNotify;
    data['professional_notify'] = this.professionalNotify;
    data['created_at'] = this.createdAt;
    data['is_self'] = this.isSelf;
    return data;
  }
}
