import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO, adapterName: "MovieVOAdapter")
class MovieVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "original_title")
  @HiveField(1)
  String originalTitle;

  @JsonKey(name: "release_date")
  @HiveField(2)
  String releaseDate;

  @JsonKey(name: "genres")
  @HiveField(3)
  List<String> genres;

  @JsonKey(name: "poster_path")
  @HiveField(4)
  String posterPath;

  @HiveField(5)
  bool isNowPlaying;

  @HiveField(6)
  bool isComingSoon;

  MovieVO(this.id, this.originalTitle, this.releaseDate, this.genres,
      this.posterPath, this.isNowPlaying, this.isComingSoon);

  factory MovieVO.fromJson(Map<String, dynamic> json) =>
      _$MovieVOFromJson(json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$MovieVOToJson(this); // Object to Json  #return type is Json Map
}
