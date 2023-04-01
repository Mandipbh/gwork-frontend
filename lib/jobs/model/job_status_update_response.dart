class JobStatusUpdateResponse {
  JobStatusUpdateResponse({
    this.success,
    this.error,
    this.message,
    this.status,
  });
  bool? success;
  String? error;
  String? message;
  int? status;

  JobStatusUpdateResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    error = json['error'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['error'] = error;
    _data['message'] = message;
    _data['status'] = status;
    return _data;
  }
}
