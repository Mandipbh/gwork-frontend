class GetProfileModel {
  GetProfileModel({
    this.success,
    this.user,
  });
  bool? success;
  User? user;

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['user'] = user;
    return _data;
  }
}

class User {
  User({
    this.id,
    this.email,
    this.name,
    this.surname,
    this.phoneNumber,
    this.propicUrl,
    this.creationDate,
    this.enabled,
    this.type,
    this.vatNumber,
    this.birthDate,
    this.image,
    this.cardHolderName,
    this.cardNumber,
    this.cardCvv,
    this.cardExpiry,
  });
  String? id;
  String? email;
  String? name;
  String? surname;
  String? phoneNumber;
  Null propicUrl;
  String? creationDate;
  int? enabled;
  int? type;
  String? vatNumber;
  String? birthDate;
  String? image;
  String? cardHolderName;
  String? cardNumber;
  String? cardCvv;
  String? cardExpiry;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    phoneNumber = json['phone_number'];
    propicUrl = null;
    creationDate = json['creation_date'];
    enabled = json['enabled'];
    type = json['type'];
    vatNumber = json['vat_number'];
    birthDate = json['birth_date'];
    image = json['image'];
    cardHolderName = json['card_holder_name'];
    cardNumber = json['card_number'];
    cardCvv = json['card_cvv'];
    cardExpiry = json['card_expiry'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['email'] = email;
    _data['name'] = name;
    _data['surname'] = surname;
    _data['phone_number'] = phoneNumber;
    _data['propic_url'] = propicUrl;
    _data['creation_date'] = creationDate;
    _data['enabled'] = enabled;
    _data['type'] = type;
    _data['vat_number'] = vatNumber;
    _data['birth_date'] = birthDate;
    _data['image'] = image;
    _data['card_holder_name'] = cardHolderName;
    _data['card_number'] = cardNumber;
    _data['card_cvv'] = cardCvv;
    _data['card_expiry'] = cardExpiry;
    return _data;
  }
}
