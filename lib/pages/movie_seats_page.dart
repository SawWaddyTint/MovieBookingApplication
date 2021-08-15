import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/date_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:MovieBookingApplication/pages/confirm_payment_page.dart';
import 'package:MovieBookingApplication/pages/ticket_details.dart';
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/data/vo/movie_seat_vo.dart';
import 'package:MovieBookingApplication/dummy/dummy_data.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/viewItems/dotted_line_view.dart';
import 'package:MovieBookingApplication/viewItems/movie_seats_item_view.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utility_function.dart';
import 'movie_choose_time_page.dart';

List<SeatPlanVO> selectedSeatList = [];
int totalTicketPrice = 0;

class MovieSeatsPage extends StatefulWidget {
  final CinemaVO cinema;
  final MovieDetailVO movie;
  final DateVO selectedDate;
  MovieSeatsPage(this.cinema, this.movie, this.selectedDate);

  @override
  _MovieSeatsPageState createState() => _MovieSeatsPageState();
}

class _MovieSeatsPageState extends State<MovieSeatsPage> {
  String token;
  MovieModel mMovieModel = MovieModelImpl();
  List<List<SeatPlanVO>> _movieSeats;
  List<SeatPlanVO> seatLists = [];

  String startTime = "";
  @override
  void initState() {
    super.initState();
    mMovieModel.getLoginDataFromDatabase().listen((value) {
      setState(() {
        token = value.token;
        this.getSeat();
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  getSeat() {
    widget.cinema.timeSlots.map((element) {
      if (element.isSelected) {
        startTime = element.startTime;
        mMovieModel
            .getSeatPlan('Bearer $token', element.id, "2021-6-28")
            .then((seats) {
          setState(() {
            _movieSeats = seats;
            this.getAllSeats(_movieSeats);
            debugPrint("Movie seats in Movie seaat page>>> " +
                this._movieSeats.toString());
          });
        }).catchError((error) {
          handleError(context, error);
          // debugPrint(error.toString());
        });
      }
    }).toList();
  } // Movie Details

  getAllSeats(List<List<SeatPlanVO>> mSeatLists) {
    seatLists = [];
    for (int i = 0; i < mSeatLists.length; i++) {
      seatLists.addAll(mSeatLists[i].map((seat) => seat));
      this.addSeatId(seatLists);
    }
    debugPrint("total seat length is >>>" + seatLists.toString());
  }

  addSeatId(List<SeatPlanVO> mseats) {
    for (int i = 0; i < mseats.length; i++) {
      seatLists[i].seatId = i + 1;
      seatLists[i].isSelected = false;
    }
  }

  getSelectedSeatList(List<SeatPlanVO> mSeats) {
    setState(() {
      selectedSeatList = [];
      selectedSeatList.addAll(mSeats.where((i) => i.isSelected).toList());
      this.getTicketTotalPrice();
      debugPrint(
          "Selected seat lists >>> " + selectedSeatList.length.toString());
    });
  }

  getTicketTotalPrice() {
    totalTicketPrice = 0;
    for (int i = 0; i < selectedSeatList.length; i++) {
      totalTicketPrice += selectedSeatList[i].price;
    }
    debugPrint(
        "selected ticket total price is >>>" + totalTicketPrice.toString());
  }

  // List<MovieSeatVO> _movieSeats = dummyMovieSeats;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: MEDIUM_MARGIN_XlARGE,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              MovieNameTimeAndCinemaSection(
                  widget.movie, widget.cinema, startTime),
              SizedBox(
                height: Action_btn_height,
              ),
              MovieSeatsSectionView(seatLists, (selectedSeatId) {
                setState(() {
                  for (int i = 0; i < seatLists.length; i++) {
                    debugPrint(
                        "Cinemas length >>>" + seatLists.length.toString());

                    if (seatLists[i].seatId == selectedSeatId) {
                      seatLists[i].isSelected = !seatLists[i].isSelected;
                    }
                  }
                  // selectedSeatList
                  //     .addAll(seatLists.where((element) => element.isSelected));
                  // debugPrint(
                  //     "Selected Seat is >>>" + selectedSeatList.toString());
                  // return cinemas;
                  this.getSelectedSeatList(seatLists);
                });
              }),
              MovieSeatGlossarySectionView(),
              DottedLineSectionView(),
              NumberOfSeatsAndTicketsSectionView(),
              SizedBox(
                height: Regular_margin_size_2X,
              ),
              // Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: Regular_margin_size),
                child: AppActionBtn(
                  "Buy Ticket for \$$totalTicketPrice",
                  () {
                    _navigateToTicketDetailsPage(
                        context,
                        selectedSeatList,
                        totalTicketPrice,
                        widget.cinema,
                        widget.movie,
                        widget.selectedDate);
                  },
                ),
              ),
              SizedBox(
                height: Medium_sizebox_height,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberOfSeatsAndTicketsSectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: MEDIUM_MARGIN_2,
        vertical: LARGE_MARGIN,
      ),
      child: Column(
        children: [
          NumberOfTicketsAndSeatsView("Tickets", "${selectedSeatList.length}"),
          SizedBox(
            height: MEDIUM_MARGIN,
          ),
          // Row(
          //   children: [
          //     Text(
          //       "Seats",
          //       style: TextStyle(
          //         color: MOVIE_SEAT_AVAILABLE_COLOR,
          //         fontSize: TEXT_REGULAR_2X,
          //       ),
          //     ),
          //     Spacer(),
          //     // Row(
          //     //   // children: <Widget>[
          //     //   //   for (var seat in selectedSeatList) SeatNum(seat),
          //     //   // ],
          //     //   children:selectedSeatList.map((seat) => SeatNum(seat)).join("/");

          //     // )
          //     NumberOfTicketsAndSeatsView("tikcets", count)
          //   ],
          // ),
          NumberOfTicketsAndSeatsView("tickets",
              selectedSeatList.map((seat) => seat.seatName).join("/"))
        ],
      ),
    );
  }
}

class SeatNum extends StatefulWidget {
  final SeatPlanVO seat;

  SeatNum(this.seat);

  @override
  _SeatNumState createState() => _SeatNumState();
}

class _SeatNumState extends State<SeatNum> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.seat.seatName,
      style: TextStyle(
        color: ComboSet_text_color,
        fontSize: TEXT_REGULAR_2X,
      ),
    );
  }
}

class NumberOfTicketsAndSeatsView extends StatelessWidget {
  final String type;
  final String count;

  NumberOfTicketsAndSeatsView(this.type, this.count);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          this.type,
          style: TextStyle(
            color: MOVIE_SEAT_AVAILABLE_COLOR,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
        Spacer(),
        Text(
          this.count,
          style: TextStyle(
            color: ComboSet_text_color,
            fontSize: TEXT_REGULAR_2X,
          ),
        ),
      ],
    );
  }
}

class MovieSeatGlossarySectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Regular_margin_size,
        vertical: MEDIUM_MARGIN_XlARGE,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: MovieSeatGlossyView("Available", MOVIE_SEAT_AVAILABLE_COLOR),
          ),
          Expanded(
            flex: 1,
            child: MovieSeatGlossyView("Reserved", MOVIE_SEAT_TAKEN_COLOR),
          ),
          Expanded(
            flex: 1,
            child: MovieSeatGlossyView("Your selection", App_theme_color),
          )
        ],
      ),
    );
  }
}

class MovieSeatGlossyView extends StatelessWidget {
  final String text;
  final Color boxColor;

  MovieSeatGlossyView(this.text, this.boxColor);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: boxColor,
          ),
        ),
        SizedBox(
          width: MEDIUM_MARGIN,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.black54, fontSize: Small_text_size),
        )
      ],
    );
  }
}

class MovieSeatsSectionView extends StatelessWidget {
  final List<SeatPlanVO> _movieSeats;
  final Function(int) getSelectedSeat;
  MovieSeatsSectionView(this._movieSeats, this.getSelectedSeat);
  @override
  Widget build(BuildContext context) {
    return (_movieSeats != null)
        ? GridView.builder(
            itemCount: _movieSeats.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 0.5),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 14,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return MovieSeatItemView(
                (selectedSeatId) {
                  getSelectedSeat(selectedSeatId);
                },
                mMovieSeatVO: _movieSeats[index],
              );
              // this.getAllSeats(_movieSeats);
            })
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

// Widget getAllSeats(movieSeats) {
//   for (int i; i < movieSeats.toString().length; i++) {
//     for(int j;j<movieSeats[i].toString().)
//   }
// }

void _navigateToTicketDetailsPage(
    BuildContext context,
    List<SeatPlanVO> selectedSeats,
    int totalPrice,
    CinemaVO cinema,
    MovieDetailVO movie,
    DateVO selectedDate) {
  if (selectedSeats.length > 0) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketDetailsPage(
            totalPrice, selectedSeats, cinema, movie, selectedDate),
      ),
    );
  } else
    Fluttertoast.showToast(
      msg: "Please Select Time!",
      textColor: App_theme_color,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
    );
}

class MovieNameTimeAndCinemaSection extends StatelessWidget {
  final MovieDetailVO movie;
  final CinemaVO cinema;
  final String startTime;
  MovieNameTimeAndCinemaSection(this.movie, this.cinema, this.startTime);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            movie.originalTitle,
            style: TextStyle(
                color: Colors.black,
                fontSize: Medium_title_text_size,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: SMALL_MARGIN,
          ),
          Text(
            cinema.name,
            style: TextStyle(
                color: Color.fromRGBO(71, 77, 87, 1.0),
                fontSize: TEXT_REGULAR_2X),
          ),
          SizedBox(
            height: SMALL_MARGIN,
          ),
          Text(
            'Wednesday, 10 May, $startTime',
            style: TextStyle(
              color: ComboSet_text_color,
              fontSize: TEXT_REGULAR_2X,
            ),
          ),
        ],
      ),
    );
  }
}

// seatNestedList.expand((seat) => seat).toList();
