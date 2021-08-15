// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_time_slot_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaTimeSlotListResponse _$CinemaTimeSlotListResponseFromJson(
    Map<String, dynamic> json) {
  return CinemaTimeSlotListResponse(
    json['code'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CinemaVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CinemaTimeSlotListResponseToJson(
        CinemaTimeSlotListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
