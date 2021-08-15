// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_plan_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatPlanResponse _$SeatPlanResponseFromJson(Map<String, dynamic> json) {
  return SeatPlanResponse(
    json['code'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) => (e as List)
            ?.map((e) => e == null
                ? null
                : SeatPlanVO.fromJson(e as Map<String, dynamic>))
            ?.toList())
        ?.toList(),
  );
}

Map<String, dynamic> _$SeatPlanResponseToJson(SeatPlanResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
