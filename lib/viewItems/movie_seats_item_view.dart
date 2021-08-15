import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/data/vo/movie_seat_vo.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';

class MovieSeatItemView extends StatelessWidget {
  final SeatPlanVO mMovieSeatVO;
  final Function(int) getSelectedSeat;
  MovieSeatItemView(this.getSelectedSeat, {this.mMovieSeatVO});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        // width: 15.0,
        // height: 15.0,
        margin: EdgeInsets.symmetric(horizontal: 1.5, vertical: 1.5),
        decoration: BoxDecoration(
            color: _getSeatColor(mMovieSeatVO),
            // color: Colors.grey,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MEDIUM_MARGIN),
              topRight: Radius.circular(MEDIUM_MARGIN),
            )),
        child: Center(
          child: Text(
            mMovieSeatVO.symbol,
            style: TextStyle(fontSize: 10.0),
          ),
        ),
      ),
      onTap: () {
        this.getSelectedSeat(mMovieSeatVO.seatId);
      },
    );
  }

  Color _getSeatColor(SeatPlanVO movieSeat) {
    if (movieSeat.isSelected == false) {
      if (movieSeat.isMovieSeatTaken()) {
        return MOVIE_SEAT_TAKEN_COLOR;
      } else if (movieSeat.isMovieSeatAvailable()) {
        return MOVIE_SEAT_AVAILABLE_COLOR;
      } else {
        return Colors.white;
      }
    } else
      return App_theme_color;
  }
}
