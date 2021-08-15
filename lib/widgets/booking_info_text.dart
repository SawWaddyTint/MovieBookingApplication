import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class BookingInfoText extends StatelessWidget {
  final String text;

  BookingInfoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: ComboSet_text_color,
        fontWeight: FontWeight.w400,
        fontSize: Subtitle_text_size,
      ),
    );
  }
}
