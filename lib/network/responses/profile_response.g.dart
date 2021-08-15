// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileResponseAdapter extends TypeAdapter<ProfileResponse> {
  @override
  final int typeId = 10;

  @override
  ProfileResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileResponse(
      fields[0] as int,
      fields[1] as String,
      fields[2] as UserDataVO,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) {
  return ProfileResponse(
    json['code'] as int,
    json['message'] as String,
    json['data'] == null
        ? null
        : UserDataVO.fromJson(json['data'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
