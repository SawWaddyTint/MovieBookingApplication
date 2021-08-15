// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_out_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckOutRequest _$CheckOutRequestFromJson(Map<String, dynamic> json) {
  return CheckOutRequest(
    json['cinema_day_timeslot_id'] as int,
    json['seat_number'] as String,
    json['booking_date'] as String,
    json['movie_id'] as int,
    json['card_id'] as int,
    (json['snacks'] as List)
        ?.map((e) =>
            e == null ? null : SnackRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CheckOutRequestToJson(CheckOutRequest instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.cinemaDayTimeSlotId,
      'seat_number': instance.seatNumber,
      'booking_date': instance.bookingDate,
      'movie_id': instance.movieId,
      'card_id': instance.cardId,
      'snacks': instance.snacks,
    };
