import 'package:json_annotation/json_annotation.dart';

part 'facebook_data_vo.g.dart';

@JsonSerializable()

class FacebookDataVO{
  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "first_name")
  String firstName;

  @JsonKey(name: "last_name")
  String lastName;

  @JsonKey(name: "email")
  String email;

  @JsonKey(name: "id")
  int id;


  FacebookDataVO(this.name, this.firstName, this.lastName, this.email, this.id);

  factory FacebookDataVO.fromJson(Map<String, dynamic> json) =>
      _$FacebookDataVOFromJson(json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$FacebookDataVOToJson(this); // Object to Json  #return type is Json Map
}