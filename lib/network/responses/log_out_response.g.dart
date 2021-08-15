// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_out_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogOutResponse _$LogOutResponseFromJson(Map<String, dynamic> json) {
  return LogOutResponse(
    json['code'] as int,
    json['message'] as String,
  );
}

Map<String, dynamic> _$LogOutResponseToJson(LogOutResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };
