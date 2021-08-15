import 'package:MovieBookingApplication/data/vo/user_data_vo.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';

part 'login_data_response.g.dart';
@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_lOG_IN_DATA_RESPONSE_DATA, adapterName: "LoginDataResponseAdapter")
class LoginDataResponse {
  @JsonKey(name: "code")
  @HiveField(0)
  int code;

  @JsonKey(name: "message")
  @HiveField(1)
  String message;

  @JsonKey(name: "data")
  @HiveField(2)
  UserDataVO data;

  @JsonKey(name: "token")
  @HiveField(3)
  String token;

  LoginDataResponse(this.code, this.message, this.data,this.token);

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataResponseToJson(this);
}