// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MovieVOAdapter extends TypeAdapter<MovieVO> {
  @override
  final int typeId = 4;

  @override
  MovieVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MovieVO(
      fields[0] as int,
      fields[1] as String,
      fields[2] as String,
      (fields[3] as List)?.cast<String>(),
      fields[4] as String,
      fields[5] as bool,
      fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MovieVO obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.originalTitle)
      ..writeByte(2)
      ..write(obj.releaseDate)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.posterPath)
      ..writeByte(5)
      ..write(obj.isNowPlaying)
      ..writeByte(6)
      ..write(obj.isComingSoon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieVO _$MovieVOFromJson(Map<String, dynamic> json) {
  return MovieVO(
    json['id'] as int,
    json['original_title'] as String,
    json['release_date'] as String,
    (json['genres'] as List)?.map((e) => e as String)?.toList(),
    json['poster_path'] as String,
    json['isNowPlaying'] as bool,
    json['isComingSoon'] as bool,
  );
}

Map<String, dynamic> _$MovieVOToJson(MovieVO instance) => <String, dynamic>{
      'id': instance.id,
      'original_title': instance.originalTitle,
      'release_date': instance.releaseDate,
      'genres': instance.genres,
      'poster_path': instance.posterPath,
      'isNowPlaying': instance.isNowPlaying,
      'isComingSoon': instance.isComingSoon,
    };
