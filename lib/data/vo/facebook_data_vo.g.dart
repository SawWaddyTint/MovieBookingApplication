// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_data_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FacebookDataVO _$FacebookDataVOFromJson(Map<String, dynamic> json) {
  return FacebookDataVO(
    json['name'] as String,
    json['first_name'] as String,
    json['last_name'] as String,
    json['email'] as String,
    json['id'] as int,
  );
}

Map<String, dynamic> _$FacebookDataVOToJson(FacebookDataVO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'id': instance.id,
    };
