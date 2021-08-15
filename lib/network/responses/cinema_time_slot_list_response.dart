import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';

part 'cinema_time_slot_list_response.g.dart';
@JsonSerializable()

class CinemaTimeSlotListResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  List<CinemaVO> data;

  CinemaTimeSlotListResponse(this.code, this.message, this.data);

  factory CinemaTimeSlotListResponse.fromJson(Map<String, dynamic> json) =>
      _$CinemaTimeSlotListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaTimeSlotListResponseToJson(this);
}