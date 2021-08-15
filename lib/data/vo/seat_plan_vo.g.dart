// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_plan_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatPlanVO _$SeatPlanVOFromJson(Map<String, dynamic> json) {
  return SeatPlanVO(
    json['id'] as int,
    json['type'] as String,
    json['seat_name'] as String,
    json['symbol'] as String,
    json['price'] as int,
    json['isSelected'] as bool,
    json['seatId'] as int,
  );
}

Map<String, dynamic> _$SeatPlanVOToJson(SeatPlanVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'seat_name': instance.seatName,
      'symbol': instance.symbol,
      'price': instance.price,
      'isSelected': instance.isSelected,
      'seatId': instance.seatId,
    };
