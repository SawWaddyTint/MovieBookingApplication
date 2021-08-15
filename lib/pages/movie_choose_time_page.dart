import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/date_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/dummy/date_data.dart';
import 'package:MovieBookingApplication/pages/movie_seats_page.dart';
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/pages/confirm_payment_page.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utility_function.dart';

class MovieChooseTimePage extends StatefulWidget {
  final MovieDetailVO movie;

  MovieChooseTimePage(this.movie);
  @override
  _MovieChooseTimePageState createState() => _MovieChooseTimePageState();
}

class _MovieChooseTimePageState extends State<MovieChooseTimePage> {
  MovieModel mMovieModel = MovieModelImpl();
  List<CinemaVO> cinemas;
  int timeSlotLen;
  List<String> nameAndTime = [];
  List<DateVO> dateList = dateData;
  DateVO selectedDate;
  String dateStr;
  String token;
  @override
  void initState() {
    super.initState();
    mMovieModel.getLoginDataFromDatabase().listen((value) {
      setState(() {
        token = value.token;
        this.getTimeSlots();
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
    // Cinema Lists
  }

  getTimeSlots() {
    dateStr = "2021" + "-" + "07" + "-" + "07";
    mMovieModel
        .getCinemaTimeSlotListFromDatabase('Bearer $token', dateStr)
        .listen((cinemaList) {
      setState(() {
        for (int i = 0; i < cinemaList.length; i++) {
          for (int j = 0; j < cinemaList[i].timeSlots.length; j++) {
            cinemaList[i].timeSlots[j].isSelected = false;
            this.timeSlotLen = cinemaList[i].timeSlots.length;
          }
        }
        this.cinemas = cinemaList;

        debugPrint("Cinema list in movie choose time page>>> " +
            this.cinemas.toString());
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  getTimeSlotsBySelectedDate({DateVO selectedDate}) {
    if (selectedDate.date.length == 1) {
      selectedDate.date = "0" + selectedDate.date;
    }
    dateStr = "2021" + "-" + "07" + "-" + selectedDate.date;
    mMovieModel
        .getCinemaTimeSlotListFromDatabase('Bearer $token', dateStr)
        .listen((cinemaList) {
      setState(() {
        for (int i = 0; i < cinemaList.length; i++) {
          for (int j = 0; j < cinemaList[i].timeSlots.length; j++) {
            cinemaList[i].timeSlots[j].isSelected = false;
            this.timeSlotLen = cinemaList[i].timeSlots.length;
          }
        }
        this.cinemas = cinemaList;

        debugPrint("Cinema list in movie choose time page>>> " +
            this.cinemas.toString());
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  getDate(int id) {
    setState(() {
      for (int i = 0; i < dateList.length; i++) {
        if (dateList[i].id == id) {
          dateList[i].isSelected = true;
          selectedDate = dateList[i];
        } else
          dateList[i].isSelected = false;
      }
      this.getTimeSlotsBySelectedDate(selectedDate: selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return (this.cinemas != null)
        ? Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: App_theme_color,
              leading: GestureDetector(
                child: Icon(
                  Icons.chevron_left,
                  color: Colors.white,
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
                    MovieChooseDateView(dateList, (id) => this.getDate(id)),
                    ChooseItemGridSessionView(cinemas,
                        getSelectedTimeSlot: (id) {
                      nameAndTime = _setSelectedItem(id);
                      //   this.cinemas.map((cinema) {
                      //   cinema.timeSlots=cinema.timeSlots.map((timeslot) {
                      //     if(timeslot.id == id){
                      //       timeslot.isSelected = true;
                      //
                      //     }
                      //     return timeslot;
                      //   });
                      //   return cinema;
                      // });
                      setState(() {
                        for (int i = 0; i < cinemas.length; i++) {
                          debugPrint(
                              "Cinemas length >>>" + cinemas.length.toString());
                          for (int j = 0;
                              j < cinemas[i].timeSlots.length;
                              j++) {
                            if (cinemas[i].timeSlots[j].id == id) {
                              cinemas[i].timeSlots[j].isSelected =
                                  !cinemas[i].timeSlots[j].isSelected;
                            } else
                              cinemas[i].timeSlots[j].isSelected = false;
                          }
                          // return cinemas;
                        }
                        // return cinemas;
                      });
                    }),
                    SizedBox(
                      height: MEDIUM_MARGIN_XlARGE,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Regular_margin_size_1X),
                      child: AppActionBtn(
                        "Next",
                        () {
                          _navigateToMovieSeatsPage(
                              context, cinemas, widget.movie, selectedDate);
                        },
                      ),
                    ),
                    SizedBox(
                      height: MEDIUM_MARGIN_XlARGE,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

List<String> _setSelectedItem(id) {
  // List<String> nameAndTime =[];
  // nameAndTime.add(selectedCinema);
  // nameAndTime.add(selectedTime);
}

void _navigateToMovieSeatsPage(BuildContext context, List<CinemaVO> cinemas,
    MovieDetailVO movie, DateVO selectedDate) {
  CinemaVO cinema;
  for (int i = 0; i < cinemas.length; i++) {
    for (int j = 0; j < cinemas[i].timeSlots.length; j++) {
      if (cinemas[i].timeSlots[j].isSelected == true) {
        cinema = cinemas[i];
      }
    }
  }
  if (cinema != null) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieSeatsPage(cinema, movie, selectedDate),
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

class ButtonViewSession extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MEDIUM_MARGIN,
      ),
      height: MEDIUM_MARGIN_XXlARGE,
      decoration: BoxDecoration(
        color: App_theme_color,
        borderRadius: BorderRadius.circular(
          MEDIUM_MARGIN,
        ),
      ),
      child: Center(
        child: Text(
          "Next",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class ChooseItemGridSessionView extends StatelessWidget {
  final List<CinemaVO> cinemas;
  final Function(int) getSelectedTimeSlot;

  ChooseItemGridSessionView(this.cinemas, {this.getSelectedTimeSlot});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
        //top: MARGIN_MEDIUM_2,
        left: MEDIUM_MARGIN_2,
        right: MEDIUM_MARGIN_2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: cinemas
            .map(
              (cinema) =>
                  ChooseItemGridView(cinema, (id) => getSelectedTimeSlot(id)),
            )
            .toList(),
      ),
    );
  }
}

class ChooseItemGridView extends StatelessWidget {
  final CinemaVO cinema;
  final Function(int) getSelectedTimeSlot;

  ChooseItemGridView(this.cinema, this.getSelectedTimeSlot);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MEDIUM_MARGIN_2,
        ),
        Text(
          cinema.name,
          style: TextStyle(
            color: Colors.black54,
            fontSize: TEXT_REGULAR_3X,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: MEDIUM_MARGIN_2,
        ),
        GridView.builder(
          itemCount: this.cinema.timeSlots.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                margin: EdgeInsets.only(
                  left: MEDIUM_MARGIN_2,
                  right: MEDIUM_MARGIN_2,
                  top: MEDIUM_MARGIN,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(
                    MEDIUM_CARD_MARGIN_2,
                  ),
                  color: (this.cinema.timeSlots[index].isSelected)
                      ? App_theme_color
                      : Colors.transparent,
                ),
                child: Center(
                  child: Text(cinema.timeSlots[index].startTime),
                ),
              ),
              onTap: () {
                getSelectedTimeSlot(cinema.timeSlots[index].id);
              },
            );
          },
        ),
      ],
    );
  }
}

class MovieChooseDateView extends StatelessWidget {
  final List<DateVO> dateList;
  final Function(int) getDate;
  MovieChooseDateView(this.dateList, this.getDate);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MOVIE_TIME_DETAIL_LIST_HEIGHT,
      color: App_theme_color,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(
            width: MEDIUM_MARGIN_2,
          );
        },
        padding: EdgeInsets.symmetric(
          horizontal: MEDIUM_MARGIN_2,
        ),
        itemCount: dateList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Container(
              color: (dateList[index].isSelected)
                  ? Colors.transparent
                  : Colors.transparent,
              margin: EdgeInsets.only(bottom: 48.0),
              child: Column(
                children: [
                  Text(
                    dateList[index].day,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_3X,
                    ),
                  ),
                  SizedBox(
                    height: MEDIUM_MARGIN,
                  ),
                  Text(
                    dateList[index].date,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: TEXT_REGULAR_3X,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              this.getDate(dateList[index].id);
            },
          );
        },
      ),
    );
  }
}
