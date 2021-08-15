import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class MovieLabelText extends StatelessWidget {
  final String labetText;
  MovieLabelText(this.labetText);
  @override
  Widget build(BuildContext context) {
    return Text(
      labetText,
      style: TextStyle(
        fontSize: Regular_margin_size_3X,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
