import 'package:MovieBookingApplication/data/vo/user_data_vo.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';

part 'profile_response.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_PROFILE_VO, adapterName: "ProfileResponseAdapter")
class ProfileResponse {
  @JsonKey(name: "code")
  @HiveField(0)
  int code;

  @JsonKey(name: "message")
  @HiveField(1)
  String message;

  @JsonKey(name: "data")
  @HiveField(2)
  UserDataVO data;

  ProfileResponse(this.code, this.message, this.data);

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
