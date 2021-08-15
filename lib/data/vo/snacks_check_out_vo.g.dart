// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snacks_check_out_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnacksCheckOutVO _$SnacksCheckOutVOFromJson(Map<String, dynamic> json) {
  return SnacksCheckOutVO(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['image'] as String,
    json['price'] as int,
    json['quantity'] as int,
    json['unit_price'] as int,
    json['total_price'] as int,
  );
}

Map<String, dynamic> _$SnacksCheckOutVOToJson(SnacksCheckOutVO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'quantity': instance.unitPrice,
      'unit_price': instance.quantity,
      'total_price': instance.totalPrice,
    };
