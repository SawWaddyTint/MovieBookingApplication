import 'package:MovieBookingApplication/network/responses/error_response.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void handleError(BuildContext context, dynamic error) {
  if (error is DioError) {
    try {
      ErrorResponse errorResponse = ErrorResponse.fromJson(error.response.data);
      showErrorAlert(context, message: errorResponse.message);
    } on Error catch (e) {
      showErrorAlert(context, message: error.toString());
    }
  } else {
    showErrorAlert(context, message: error.toString());
  }
}

void showErrorAlert(BuildContext context, {String message}) {
  Fluttertoast.showToast(
    msg: message,
    textColor: App_theme_color,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: Colors.white,
  );
}
