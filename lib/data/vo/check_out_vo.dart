import 'package:json_annotation/json_annotation.dart';

import 'package:MovieBookingApplication/data/vo/snacks_check_out_vo.dart';
import 'package:MovieBookingApplication/data/vo/time_slot_vo.dart';

part 'check_out_vo.g.dart';

@JsonSerializable()
class CheckOutVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "booking_no")
  String bookingNo;

  @JsonKey(name: "booking_date")
  String bookingDate;

  @JsonKey(name: "row")
  String row;

  @JsonKey(name: "seat")
  String seat;

  @JsonKey(name: "total_seat")
  int totalSeat;

  @JsonKey(name: "total")
  String total;

  @JsonKey(name: "movie_id")
  int movieId;

  @JsonKey(name: "cinema_id")
  int cinemaId;

  @JsonKey(name: "username")
  String userName;

  @JsonKey(name: "timeslot")
  TimeSlotVO timeSlotVO;

  @JsonKey(name: "snacks")
  List<SnacksCheckOutVO> snacks;

  CheckOutVO(
    this.id,
    this.bookingNo,
    this.bookingDate,
    this.row,
    this.seat,
    this.totalSeat,
    this.total,
    this.movieId,
    this.cinemaId,
    this.userName,
    this.timeSlotVO,
    this.snacks,
  );

  factory CheckOutVO.fromJson(Map<String, dynamic> json) =>
      _$CheckOutVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$CheckOutVOToJson(this); // Object to Json  #return type is Json Map
}
