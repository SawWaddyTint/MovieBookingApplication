import 'package:MovieBookingApplication/data/vo/card_vo.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';

part 'add_new_card_response.g.dart';

@JsonSerializable()
class AddNewCardResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  List<CardVO> data;

  AddNewCardResponse(this.code, this.message, this.data);

  factory AddNewCardResponse.fromJson(Map<String, dynamic> json) =>
      _$AddNewCardResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddNewCardResponseToJson(this);
}
