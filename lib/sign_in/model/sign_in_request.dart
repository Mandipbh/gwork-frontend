import 'package:json_annotation/json_annotation.dart';
part 'sign_in_request.g.dart';

@JsonSerializable()
class SignInRequest{
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String password;

  SignInRequest({required this.phoneNumber,required this.password});

  factory SignInRequest.fromJson(Map<String,dynamic> data) => _$SignInRequestFromJson(data);

  Map<String,dynamic> toJson() => _$SignInRequestToJson(this);
  
}