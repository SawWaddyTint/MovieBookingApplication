import 'dart:io';

import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/card_vo.dart';
import 'package:MovieBookingApplication/data/vo/check_out_vo.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/date_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:MovieBookingApplication/data/vo/snack_vo.dart';
import 'package:MovieBookingApplication/data/vo/user_data_vo.dart';
import 'package:MovieBookingApplication/network/requests/check_out_request.dart';
import 'package:MovieBookingApplication/network/requests/snack_request.dart';
import 'package:MovieBookingApplication/network/responses/checkout_response.dart';
import 'package:MovieBookingApplication/pages/ticket_details.dart';
import 'package:MovieBookingApplication/widgets/form_field_name.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:MovieBookingApplication/pages/add_new_card_page.dart';
import 'package:MovieBookingApplication/pages/payslip_page.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/resources/strings.dart';

import 'package:MovieBookingApplication/widgets/app_action_btn.dart';

import '../utility_function.dart';

int focusIndex;
// List<CardVO> newCardLists;
bool showForm = false;
TextEditingController cardNumber1 = TextEditingController();
TextEditingController cardHolder1 = TextEditingController();
TextEditingController expDate1 = TextEditingController();
TextEditingController cvc1 = TextEditingController();

class ConfirmPaymentPage extends StatefulWidget {
  final CinemaVO cinema;
  final List<SeatPlanVO> selectedSeats;
  final int totalPrice;
  final MovieDetailVO movie;
  final DateVO selectedDate;
  final List<SnackVO> snackList;

  // final List<CardVO> newCardLists;
  // BuildContext context;
  ConfirmPaymentPage(this.cinema, this.selectedSeats, this.totalPrice,
      this.movie, this.selectedDate, this.snackList);
  @override
  _ConfirmPaymentPageState createState() => _ConfirmPaymentPageState();
}

class _ConfirmPaymentPageState extends State<ConfirmPaymentPage> {
  String token;
  UserDataVO userData;
  MovieModel mMovieModel = MovieModelImpl();
  List<CardVO> cardLists;
  MovieDetailVO movie;
  CheckoutResponse checkoutResponse;
  CheckOutVO checkOutData;
  @override
  void initState() {
    super.initState();
    cardNumber1.text = "";
    cardHolder1.text = "";
    expDate1.text = "";

    mMovieModel.getLoginDataFromDatabase().listen((value) {
      // userData = value.data;
      token = value.token;
      debugPrint("token is >>> " + token);
      // cardLists = value.data.cards;
      // focusIndex = cardLists.length - 1;

      // this.getSeat();
      mMovieModel
          .getProfileDataFromDatabase('Bearer $token')
          .listen((userData) {
        setState(() {
          cardLists = userData.data.cards;
        });
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
    // mMovieModel.getSigleMovieFromDatabase().then((value) {
    //   movie = value;
    // });
  }

  void _showAddNewCard() async {
    final newCardLists = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddNewCardPage(cardLists),
      ),
    );
    setState(() {
      if (newCardLists != null) {
        showForm = true;
      } else
        showForm = false;
      // cardLists = newCardLists as List<CardVO>;

      cardNumber1.text = cardLists[cardLists.length - 1].cardNumber;
      cardHolder1.text = cardLists[cardLists.length - 1].cardHolder;
      expDate1.text = cardLists[cardLists.length - 1].expirationDate;
      // widget.cvc.text = cardLists[cardLists.length-1].cvc
    });
  }

  goCheckOut(
      BuildContext context,
      CinemaVO cinema,
      List<SeatPlanVO> selectedSeats,
      MovieDetailVO movie,
      int totalPrice,
      List<SnackVO> snackList,
      DateVO selectedDate) {
    try {
      CheckOutRequest checkOutRequest;
      List<SnackVO> selectedSnacks;
      int cinemaDayTimeSlotId;
      int cardId;
      String seatNumber;
      String dateStr;
      // selectedSnacks.addAll(snackList.where((element) => element.quantity > 0));
      selectedSnacks = snackList.where((i) => i.quantity > 0).toList();

      for (int i = 0; i < cinema.timeSlots.length; i++) {
        if (cinema.timeSlots[i].isSelected == true) {
          cinemaDayTimeSlotId = cinema.timeSlots[i].id;
        }

        cardId = cardLists[cardLists.length - 1].id;

        seatNumber = selectedSeats.map((seat) => seat.seatName).join(",");
        // checkOutRequest.seatNumber = seatNames;
        dateStr = "2021" + "-" + "07" + "-" + selectedDate.date;

        List<SnackRequest> snackReq;
        snackReq = selectedSnacks.map((snack) {
          return SnackRequest(snack.id, snack.quantity);
        }).toList();

        debugPrint("check out request >>>" + checkOutRequest.toString());

        mMovieModel
            .checkOut(
                'Bearer $token',
                CheckOutRequest(cinemaDayTimeSlotId, seatNumber, dateStr,
                    movie.id, cardId, snackReq))
            .then((value) {
          checkoutResponse = value;
          checkOutData = value.data;
          debugPrint("check out response >>> " + checkoutResponse.toString());
          if (value.message == "Success") {
            Fluttertoast.showToast(
              msg: "Checked Out Successfully",
              textColor: App_theme_color,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.white,
            );

            _navigateToPayslipPage(
                context, checkOutData, selectedDate, cinema, movie);
          }
        }).catchError((error) {
          handleError(context, error);
          // debugPrint(error.toString());
        });
      }
    } on Error catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        textColor: App_theme_color,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.white,
      );
    }
  }

  void _navigateToPayslipPage(BuildContext context, CheckOutVO checkOutData,
      DateVO selectedDate, CinemaVO cinema, MovieDetailVO movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PayslipPage(checkOutData, selectedDate, cinema, movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Icon(
            Icons.chevron_left,
            color: Colors.black,
            size: Medium_sizebox_height,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Container(
          child: Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentAmountView(),
          SizedBox(
            height: Regular_margin_size,
          ),
          CardSwipeView(cardLists),
          // Spacer(),
          CardHolderInfoView(),
          AddNewCardView(
            () => _showAddNewCard(),
          ),
          SizedBox(
            height: Medium_margin_size,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: Regular_margin_size_2X),
            child: AppActionBtn(
              Confirm_txt,
              () {
                this.goCheckOut(
                    context,
                    widget.cinema,
                    widget.selectedSeats,
                    widget.movie,
                    widget.totalPrice,
                    widget.snackList,
                    widget.selectedDate);
                // _navigateToPayslipPage(
                //     context,
                //     widget.cinema,
                //     widget.selectedSeats,
                //     widget.movie,
                //     widget.totalPrice,
                //     widget.selectedDate);
              },
            ),
          ),
          SizedBox(
            height: Regular_margin_size_2X,
          ),
        ],
      )),
    );
  }
}

class CardHolderInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showForm,
      child: Expanded(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Regular_margin_size_2X),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FormFieldName(Card_num_txt),
              TextField(
                controller: cardNumber1,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: Medium_margin_size,
              ),
              FormFieldName(Card_holder_txt),
              TextField(
                controller: cardHolder1,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: Medium_margin_size,
              ),
              Row(
                children: [
                  Flexible(child: FormFieldName(Expiration_txt)),
                  SizedBox(
                    width: 75.0,
                  ),
                  Flexible(child: FormFieldName(Cvc_txt)),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: TextField(
                      controller: expDate1,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Medium_title_text_size,
                  ),
                  Flexible(
                    child: TextField(
                      controller: cvc1,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Medium_margin_size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddNewCardView extends StatelessWidget {
  final Function onTapAdd;
  AddNewCardView(this.onTapAdd);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Regular_margin_size_2X),
      child: GestureDetector(
        onTap: () {
          this.onTapAdd();
        },
        child: Row(
          children: [
            Icon(
              Icons.add_circle,
              color: Subtotal_text_color,
              size: Medium_margin_size,
            ),
            SizedBox(
              width: Xs_margin_size,
            ),
            Text(
              Add_new_card_txt,
              style: TextStyle(
                fontSize: Regular_title_text_size,
                color: Subtotal_text_color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardSwipeView extends StatelessWidget {
  final List<CardVO> showCardLists;
  CardSwipeView(this.showCardLists);
  @override
  Widget build(BuildContext context) {
    return (showCardLists != null)
        ? Container(
            height: 180.0,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 400.0,
                enlargeCenterPage: true,
                // enableInfiniteScroll: false,
                initialPage: showCardLists.length - 1,
              ),
              items: showCardLists.map((card) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        // height: 180.0,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.transparent),
                        child: Card(
                          child: Stack(children: [
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromRGBO(141, 119, 253, 1.0),
                                      Color.fromRGBO(168, 122, 255, 1.0)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "VISA",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Regular_title_text_size,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 26,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* * * *  * * * *  * * * *",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Small_text_size,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Spacer(),
                                      Text(
                                        card.cardNumber,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Regular_margin_size_2X,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: Regular_margin_size_2X,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Card Holder",
                                        style: TextStyle(
                                          color: Card_holder_text_color,
                                          fontWeight: FontWeight.w400,
                                          fontSize: Subtitle_text_size,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "Expires",
                                        style: TextStyle(
                                          color: Card_holder_text_color,
                                          fontWeight: FontWeight.w400,
                                          fontSize: Subtitle_text_size,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        card.cardHolder,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Subtitle_text_size,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        card.expirationDate,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: Subtitle_text_size,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ]),
                        ));
                  },
                );
              }).toList(),
            ))
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

// class CardSwipeView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 180.0,
//         child: Swiper(
//           fade: 0.3,
//           itemBuilder: (BuildContext context, int index) {
//             // );
//             return Card(
//               child: Stack(children: [
//                 Positioned.fill(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(6.0),
//                       gradient: LinearGradient(
//                         begin: Alignment.topCenter,
//                         end: Alignment.bottomCenter,
//                         colors: [
//                           Color.fromRGBO(141, 119, 253, 1.0),
//                           Color.fromRGBO(168, 122, 255, 1.0)
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text(
//                             "VISA",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: Regular_title_text_size,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Spacer(),
//                           Icon(
//                             Icons.more_horiz,
//                             color: Colors.white,
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: 26,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "* * * *  * * * *  * * * *",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: Regular_title_text_size,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Spacer(),
//                           Text(
//                             "8014",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: Regular_margin_size_3X,
//                                 fontWeight: FontWeight.w500),
//                           )
//                         ],
//                       ),
//                       SizedBox(
//                         height: Regular_margin_size_2X,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Card Holder",
//                             style: TextStyle(
//                               color: Card_holder_text_color,
//                               fontWeight: FontWeight.w400,
//                               fontSize: Subtitle_text_size,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             "Expires",
//                             style: TextStyle(
//                               color: Card_holder_text_color,
//                               fontWeight: FontWeight.w400,
//                               fontSize: Subtitle_text_size,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 4.0,
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                             "Lily Johnson",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: Subtitle_text_size,
//                             ),
//                           ),
//                           Spacer(),
//                           Text(
//                             "08/21",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               fontSize: Subtitle_text_size,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ]),
//             );
//           },
//           // itemHeight: 100,
//           // itemWidth: 200,
//           itemCount: 10,
//           viewportFraction: 0.8,
//           scale: 0.9,
//         ));
//   }
// }

class PaymentAmountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Regular_margin_size_2X),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment amount",
              style: TextStyle(
                color: ComboSet_details_color,
                fontWeight: FontWeight.w400,
                fontSize: Subtitle_text_size,
              ),
            ),
            SizedBox(
              height: XXS_margin_size,
            ),
            Text(
              "\$ 926.21",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: Regular_sizebox_height,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
