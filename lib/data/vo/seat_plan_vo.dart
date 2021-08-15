import 'package:MovieBookingApplication/utils/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_plan_vo.g.dart';

@JsonSerializable()
class SeatPlanVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "type")
  String type;

  @JsonKey(name: "seat_name")
  String seatName;

  @JsonKey(name: "symbol")
  String symbol;

  @JsonKey(name: "price")
  int price;

  bool isSelected;

  int seatId;

  SeatPlanVO(this.id, this.type, this.seatName, this.symbol, this.price,
      this.isSelected, this.seatId);

  factory SeatPlanVO.fromJson(Map<String, dynamic> json) =>
      _$SeatPlanVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$SeatPlanVOToJson(this); // Object to Json  #return type is Json Map
  bool isMovieSeatAvailable() {
    return type == SEAT_TYPE_AVAILABLE;
  }

  bool isMovieSeatTaken() {
    return type == SEAT_TYPE_TAKEN;
  }

  bool isMovieSeatRowTitle() {
    return type == SEAT_TYPE_TEXT;
  }

  bool isMovieSeatEmpty() {
    return type == SEAT_TYPE_EMPTY;
  }
}
