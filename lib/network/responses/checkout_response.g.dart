// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checkout_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckoutResponse _$CheckoutResponseFromJson(Map<String, dynamic> json) {
  return CheckoutResponse(
    json['code'] as int,
    json['message'] as String,
  )..data = json['data'] == null
      ? null
      : CheckOutVO.fromJson(json['data'] as Map<String, dynamic>);
}

Map<String, dynamic> _$CheckoutResponseToJson(CheckoutResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
