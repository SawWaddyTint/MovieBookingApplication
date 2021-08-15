import 'package:json_annotation/json_annotation.dart';

part 'snacks_check_out_vo.g.dart';

@JsonSerializable()
class SnacksCheckOutVO {
  @JsonKey(name: "id")
  int id;

  @JsonKey(name: "name")
  String name;

  @JsonKey(name: "description")
  String description;

  @JsonKey(name: "image")
  String image;

  @JsonKey(name: "price")
  int price;

  @JsonKey(name: "quantity")
  int unitPrice;

  @JsonKey(name: "unit_price")
  int quantity;

  @JsonKey(name: "total_price")
  int totalPrice;

  SnacksCheckOutVO(
    this.id,
    this.name,
    this.description,
    this.image,
    this.price,
    this.unitPrice,
    this.quantity,
    this.totalPrice,
  );

  factory SnacksCheckOutVO.fromJson(Map<String, dynamic> json) =>
      _$SnacksCheckOutVOFromJson(
          json); // Json to Object #return type is factory object
  Map<String, dynamic> toJson() => _$SnacksCheckOutVOToJson(
      this); // Object to Json  #return type is Json Map
}
