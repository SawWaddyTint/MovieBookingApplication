import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class AppActionBtn extends StatelessWidget {
  final String labelText;
  final Function onTapBtn;
  final bool isGhostBtn;

  AppActionBtn(this.labelText, this.onTapBtn, {this.isGhostBtn = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Action_btn_height,
      width: double.infinity,
      child: RaisedButton(
        color: App_theme_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(XXS_margin_size),
          ),
          side: (isGhostBtn)
              ? BorderSide(
                  color: Welcome_logIn_subTitle_color,
                )
              : BorderSide(color: App_theme_color),
        ),
        child: Center(
          child: Text(
            labelText,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Subtitle_text_size),
          ),
        ),
        onPressed: () {
          this.onTapBtn();
        },
      ),
    );
  }
}
