import 'package:json_annotation/json_annotation.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';

part 'movie_list_response.g.dart';
@JsonSerializable()

class MovieListResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  List<MovieVO> data;

  MovieListResponse(this.code, this.message, this.data);

  factory MovieListResponse.fromJson(Map<String, dynamic> json) =>
      _$MovieListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieListResponseToJson(this);
}