import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class FormFieldName extends StatelessWidget {
  final String fieldName;
  FormFieldName(this.fieldName);
  @override
  Widget build(BuildContext context) {
    return Text(
      fieldName,
      style: TextStyle(
        color: Welcome_logIn_subTitle_color,
        fontWeight: FontWeight.w400,
        fontSize: Subtitle_text_size,
      ),
    );
  }
}
