import 'package:MovieBookingApplication/data/vo/time_slot_vo.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cinema_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_CINEMA_VO, adapterName: "CinemaVOAdapter")
class CinemaVO {
  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int cinemaId;

  @JsonKey(name: "cinema")
  @HiveField(1)
  String name;

  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeSlotVO> timeSlots;

  @HiveField(3)
  List<String> dates;

  CinemaVO(this.cinemaId, this.name, this.timeSlots, this.dates);

  factory CinemaVO.fromJson(Map<String, dynamic> json) =>
      _$CinemaVOFromJson(json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$CinemaVOToJson(this); // Object to Json  #return type is Json Map
}
