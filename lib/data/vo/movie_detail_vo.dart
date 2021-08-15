import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/cast_vo.dart';

part 'movie_detail_vo.g.dart';

@JsonSerializable()
@HiveType(
    typeId: HIVE_TYPE_ID_MOVIE_DETAIL_VO, adapterName: "MovieDetailVOAdapter")
class MovieDetailVO {
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

  @JsonKey(name: "overview")
  @HiveField(4)
  String overview;

  @JsonKey(name: "rating")
  @HiveField(5)
  double rating;

  @JsonKey(name: "runtime")
  @HiveField(6)
  int runtime;

  @JsonKey(name: "poster_path")
  @HiveField(7)
  String posterPath;

  @JsonKey(name: "casts")
  @HiveField(8)
  List<CastVO> casts;

  MovieDetailVO(this.id, this.originalTitle, this.releaseDate, this.genres,
      this.overview, this.rating, this.runtime, this.posterPath, this.casts);

  factory MovieDetailVO.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$MovieDetailVOToJson(this); // Object to Json  #return type is Json Map
}
