// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_new_card_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddNewCardResponse _$AddNewCardResponseFromJson(Map<String, dynamic> json) {
  return AddNewCardResponse(
    json['code'] as int,
    json['message'] as String,
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : CardVO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AddNewCardResponseToJson(AddNewCardResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
