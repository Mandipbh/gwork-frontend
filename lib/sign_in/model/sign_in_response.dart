import 'package:json_annotation/json_annotation.dart';
part 'sign_in_response.g.dart';

@JsonSerializable()
class SignInResponse {
  final bool success;
  final int? status;
  @JsonKey(name: 'is_verified')
  final int? isVerified;
  final String? token;
  final String? error;

  SignInResponse(
      {required this.success,
      this.status,
      this.isVerified,
      this.token,
      this.error});

  factory SignInResponse.fromJson(Map<String,dynamic> data) => _$SignInResponseFromJson(data);

  Map<String,dynamic> toJson() => _$SignInResponseToJson(this);

}
