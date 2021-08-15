import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';

part 'seat_plan_response.g.dart';
@JsonSerializable()

class SeatPlanResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  List<List<SeatPlanVO>> data;


  SeatPlanResponse(this.code, this.message, this.data);

  factory SeatPlanResponse.fromJson(Map<String, dynamic> json) =>
      _$SeatPlanResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeatPlanResponseToJson(this);
}