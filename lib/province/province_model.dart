class ProviceModel {
  ProviceModel({
    required this.success,
    required this.provice,
  });
  late final bool success;
  late final List<String> provice;

  ProviceModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    provice = List.castFrom<dynamic, String>(json['provice']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['provice'] = provice;
    return _data;
  }
}
