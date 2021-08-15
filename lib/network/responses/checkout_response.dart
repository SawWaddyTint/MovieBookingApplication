import 'package:MovieBookingApplication/data/vo/check_out_vo.dart';

import 'package:json_annotation/json_annotation.dart';

part 'checkout_response.g.dart';

@JsonSerializable()
class CheckoutResponse {
  @JsonKey(name: "code")
  int code;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  CheckOutVO data;

  CheckoutResponse(this.code, this.message);

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) =>
      _$CheckoutResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CheckoutResponseToJson(this);
}
