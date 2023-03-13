class UpdateVatNumberModel {
  String? vatNumber;

  UpdateVatNumberModel({
    this.vatNumber,
  });

  UpdateVatNumberModel.fromJson(Map<String, dynamic> json) {
    vatNumber = json['vat_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['vat_number'] = vatNumber;
    return data;
  }
}
