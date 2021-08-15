import 'package:MovieBookingApplication/data/vo/snack_vo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';

part 'snack_response.g.dart';

@JsonSerializable()
class SnackResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  List<SnackVO> data;

  SnackResponse(this.code, this.message, this.data);

  factory SnackResponse.fromJson(Map<String, dynamic> json) =>
      _$SnackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SnackResponseToJson(this);
}
