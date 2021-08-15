// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snack_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnackVOAdapter extends TypeAdapter<SnackVO> {
  @override
  final int typeId = 9;

  @override
  SnackVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SnackVO(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as String,
      fields[5] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SnackVO obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnackVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SnackVO _$SnackVOFromJson(Map<String, dynamic> json) {
  return SnackVO(
    json['id'] as int,
    json['name'] as String,
    json['description'] as String,
    json['price'] as int,
    json['image'] as String,
    json['quantity'] as int,
  );
}

Map<String, dynamic> _$SnackVOToJson(SnackVO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'image': instance.image,
      'quantity': instance.quantity,
    };
