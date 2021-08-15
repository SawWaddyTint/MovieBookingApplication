import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';

part 'movie_detail_response.g.dart';
@JsonSerializable()

class MovieDetailResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  MovieDetailVO data;


  MovieDetailResponse(this.code, this.message, this.data);

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailResponseToJson(this);
}