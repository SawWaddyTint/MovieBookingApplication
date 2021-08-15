import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_slot_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_TIME_SLOT_VO, adapterName: "TimeSlotVOAdapter")
class TimeSlotVO {
  @JsonKey(name: "cinema_day_timeslot_id")
  @HiveField(0)
  int id;

  @JsonKey(name: "start_time")
  @HiveField(1)
  String startTime;

  @HiveField(2)
  bool isSelected;

  TimeSlotVO(this.id, this.startTime, this.isSelected);

  factory TimeSlotVO.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$TimeSlotVOToJson(this); // Object to Json  #return type is Json Map
}
