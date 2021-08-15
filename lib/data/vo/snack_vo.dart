import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'snack_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_SNACK_VO, adapterName: "SnackVOAdapter")
class SnackVO {
  @JsonKey(name: "id")
  @HiveField(0)
  int id;

  @JsonKey(name: "name")
  @HiveField(1)
  String name;

  @JsonKey(name: "description")
  @HiveField(2)
  String description;

  @JsonKey(name: "price")
  @HiveField(3)
  int price;

  @JsonKey(name: "image")
  @HiveField(4)
  String image;

  @HiveField(5)
  int quantity;

  SnackVO(this.id, this.name, this.description, this.price, this.image,
      this.quantity);

  factory SnackVO.fromJson(Map<String, dynamic> json) =>
      _$SnackVOFromJson(json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() =>
      _$SnackVOToJson(this); // Object to Json  #return type is Json Map
}
