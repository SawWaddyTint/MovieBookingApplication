// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginDataResponseAdapter extends TypeAdapter<LoginDataResponse> {
  @override
  final int typeId = 2;

  @override
  LoginDataResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginDataResponse(
      fields[0] as int,
      fields[1] as String,
      fields[2] as UserDataVO,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoginDataResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginDataResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataResponse _$LoginDataResponseFromJson(Map<String, dynamic> json) {
  return LoginDataResponse(
    json['code'] as int,
    json['message'] as String,
    json['data'] == null
        ? null
        : UserDataVO.fromJson(json['data'] as Map<String, dynamic>),
    json['token'] as String,
  );
}

Map<String, dynamic> _$LoginDataResponseToJson(LoginDataResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
    };
