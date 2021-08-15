// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailResponse _$MovieDetailResponseFromJson(Map<String, dynamic> json) {
  return MovieDetailResponse(
    json['code'] as int,
    json['message'] as String,
    json['data'] == null
        ? null
        : MovieDetailVO.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$MovieDetailResponseToJson(
        MovieDetailResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
