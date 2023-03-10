/* 
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class SignUpModel {
  String? firstname;
  String? lastname;
  String? email;
  String? phonenumber;
  String? password;
  String? vatnumber;
  String? birthdate;
  String? role;
  String? cardholdername;
  String? cardnumber;
  String? cardexpiry;
  String? cardcvv;
  String? image;

  SignUpModel(
      {this.firstname,
      this.lastname,
      this.email,
      this.phonenumber,
      this.password,
      this.vatnumber,
      this.birthdate,
      this.role,
      this.cardholdername,
      this.cardnumber,
      this.cardexpiry,
      this.cardcvv,
      this.image});

  SignUpModel.fromJson(Map<String, dynamic> json) {
    firstname = json['first_name'];
    lastname = json['last_name'];
    email = json['email'];
    phonenumber = json['phone_number'];
    password = json['password'];
    vatnumber = json['vat_number'];
    birthdate = json['birth_date'];
    role = json['role'];
    cardholdername = json['card_holder_name'];
    cardnumber = json['card_number'];
    cardexpiry = json['card_expiry'];
    cardcvv = json['card_cvv'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = firstname;
    data['last_name'] = lastname;
    data['email'] = email;
    data['phone_number'] = phonenumber;
    data['password'] = password;
    data['vat_number'] = vatnumber;
    data['birth_date'] = birthdate;
    data['role'] = role;
    data['card_holder_name'] = cardholdername;
    data['card_number'] = cardnumber;
    data['card_expiry'] = cardexpiry;
    data['card_cvv'] = cardcvv;
    data['image'] = image;
    return data;
  }
}
