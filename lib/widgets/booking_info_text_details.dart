import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class BookingInfoTextDetails extends StatelessWidget {
  final String text;

  BookingInfoTextDetails(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: ComboSet_details_color,
        fontWeight: FontWeight.w400,
        fontSize: Regular_text_size,
      ),
    );
  }
}
