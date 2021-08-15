
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/data/vo/cast_vo.dart';
import 'package:MovieBookingApplication/network/api_constants.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class CircleAvatarProfile extends StatelessWidget {
  final CastVO cast;
  final double rad;
  CircleAvatarProfile(this.rad,this.cast);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: rad,
          backgroundImage: NetworkImage("$IMAGE_BASE_URL${cast.profilePath}"),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(
          width: Small_margin_size,
        )
      ],
    );
  }
}
