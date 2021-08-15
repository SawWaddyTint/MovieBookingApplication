import 'package:flutter/material.dart';

class DateVO {
  int id;
  String day;
  String date;
  bool isSelected;
  DateVO({
    this.id,
    this.day,
    this.date,
    this.isSelected = false,
  });
}
