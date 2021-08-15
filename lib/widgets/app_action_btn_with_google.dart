import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class AppActionBtnWithGoogle extends StatelessWidget {
  final String btnLabel;
  final Image btnIcon;
  final Function registerWithGoogle;

  AppActionBtnWithGoogle(
    this.btnLabel,
    this.btnIcon,
    this.registerWithGoogle,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Action_btn_height,
      width: double.infinity,
      child: RaisedButton(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(XXS_margin_size),
            ),
            side: BorderSide(
              color: Welcome_logIn_subTitle_color,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: Small_margin_size),
            child: Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                btnIcon,
                SizedBox(
                  width: Medium_title_text_size,
                ),
                Text(
                  btnLabel,
                  style: TextStyle(
                      color: Welcome_logIn_subTitle_color,
                      fontWeight: FontWeight.w400,
                      fontSize: Subtitle_text_size),
                )
              ],
            ),
          ),
          onPressed: () {
            this.registerWithGoogle();
          }),
    );
  }
}
