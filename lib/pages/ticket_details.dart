import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/date_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';

import 'package:MovieBookingApplication/data/vo/snack_vo.dart';
import 'package:MovieBookingApplication/pages/confirm_payment_page.dart';
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/pages/movie_choose_time_page.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn.dart';
import 'package:MovieBookingApplication/widgets/booking_info_text.dart';
import 'package:MovieBookingApplication/widgets/booking_info_text_details.dart';
import 'package:MovieBookingApplication/widgets/movie_label_text.dart';

import '../utility_function.dart';

List<SnackVO> snackList;

class TicketDetailsPage extends StatefulWidget {
  final List<SeatPlanVO> selectedSeats;
  final CinemaVO cinema;
  final MovieDetailVO movie;
  final DateVO selectedDate;
  int totalPrice;
  TicketDetailsPage(this.totalPrice, this.selectedSeats, this.cinema,
      this.movie, this.selectedDate);

  @override
  _TicketDetailsPageState createState() => _TicketDetailsPageState();
}

class _TicketDetailsPageState extends State<TicketDetailsPage> {
  String token;
  MovieModel mMovieModel = MovieModelImpl();

  @override
  void initState() {
    super.initState();
    mMovieModel.getLoginDataFromDatabase().listen((value) {
      setState(() {
        token = value.token;
        this.getSnackListFromDatabase();
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  // getSnackList() {
  //   mMovieModel.getSnacks('Bearer $token').then((snacks) {
  //     setState(() {
  //       snackList = snacks;
  //       for (int i = 0; i < snackList.length; i++) {
  //         snackList[i].quantity = 0;
  //       }
  //     });
  //   }).catchError((error) {
  //     handleError(context, error);
  //     // debugPrint(error.toString());
  //   });
  // }
  getSnackListFromDatabase() {
    mMovieModel.getSnacksFromDatabase('Bearer $token').listen((snacks) {
      setState(() {
        snackList = snacks;
        for (int i = 0; i < snackList.length; i++) {
          snackList[i].quantity = 0;
        }
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  getIncreaseCount(int snackId) {
    setState(() {
      for (int i = 0; i < snackList.length; i++) {
        if (snackList[i].id == snackId) {
          snackList[i].quantity += 1;
          widget.totalPrice += snackList[i].price;
        }
        // else
        //   snackList[i].count = 0;
      }
    });
  }

  getDescPrice(int snackId) {
    setState(() {
      for (int i = 0; i < snackList.length; i++) {
        if (snackList[i].id == snackId) {
          if (snackList[i].quantity != 0) {
            snackList[i].quantity -= 1;
            widget.totalPrice -= snackList[i].price;
          } else
            snackList[i].quantity = 0;
        }
      }

      // else
      //   snackList[i].count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (snackList != null)
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(right: Large_sizebox_height),
                child: GestureDetector(
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: Medium_sizebox_height,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ComboSetListView(
                        (snackId) => {this.getIncreaseCount(snackId)},
                        (snackId) => {this.getDescPrice(snackId)}),
                    SizedBox(
                      height: Regular_margin_size,
                    ),
                    PromoAndSubTotalView(widget.totalPrice),
                    SizedBox(
                      height: Regular_margin_size_3X,
                    ),
                    PaymentMethodView(),
                    SizedBox(
                      height: Regular_margin_size_2X,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 17.0),
                      child: AppActionBtn(
                        "Pay \$${widget.totalPrice}",
                        () {
                          _navigateToConfirmPaymentPage(
                            context,
                            widget.cinema,
                            widget.selectedSeats,
                            widget.totalPrice,
                            widget.movie,
                            widget.selectedDate,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: Regular_margin_size_2X,
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }
}

class ComboSetListView extends StatelessWidget {
  final Function(int) getIncPrice;
  final Function(int) getDescPrice;
  ComboSetListView(this.getIncPrice, this.getDescPrice);
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: snackList
            .map(
              (snack) => ComboSetView(snack, (snackId) {
                getIncPrice(snackId);
              }, (snackId) {
                getDescPrice(snackId);
              }),
            )
            .toList()
        // ComboSetView(
        //   "Combo set M",
        //   "Combo set M 22ox. Coke (X1)\nand medium popcorn (X1)",
        //   "15\$",
        // ),
        // SizedBox(
        //   height: Regular_margin_size,
        // ),
        // ComboSetView(
        //   "Combo set L",
        //   "Combo set M 32ox. Coke (X1)\nand large popcorn (X1) ",
        //   "18\$",
        // ),
        // SizedBox(
        //   height: Regular_margin_size,
        // ),
        // ComboSetView(
        //   "Combo for 2",
        //   "Combo set M 2 32ox. Coke (X1)\nand large popcorn (X1) ",
        //   "20\$",
        // ),

        );
  }
}

class ComboSetView extends StatelessWidget {
  final SnackVO snack;
  final Function(int) getIncPrice;
  final Function(int) getDescPrice;
  ComboSetView(this.snack, this.getIncPrice, this.getDescPrice);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BookingInfoText(snack.name),
      subtitle: BookingInfoTextDetails(snack.description),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "${snack.price}\$",
            style: TextStyle(
              color: ComboSet_text_color,
              fontWeight: FontWeight.w400,
              fontSize: Subtitle_text_size,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 28.0,
                width: 28.0,
                child: OutlinedButton(
                  onPressed: () {
                    getDescPrice(snack.id);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "-",
                    style: TextStyle(
                      fontSize: Regular_margin_size_2X,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Container(
                height: 28.0,
                width: 28.0,
                child: OutlinedButton(
                  onPressed: null,
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Text(
                    snack.quantity.toString(),
                    style: TextStyle(
                      fontSize: Regular_margin_size_2X,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              Container(
                height: 28.0,
                width: 28.0,
                child: OutlinedButton(
                  onPressed: () {
                    getIncPrice(snack.id);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  child: Text(
                    "+",
                    style: TextStyle(
                      fontSize: Regular_margin_size_2X,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5.0,
          )
        ],
      ),
    );
  }
}
// class ComboSetView extends StatelessWidget {
//   // final String text;
//   // final String detailsText;
//   // final String priceText;
//   final SnackVO snack;
//   ComboSetView(this.snack);

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       title: BookingInfoText(snack.name),
//       subtitle: BookingInfoTextDetails(snack.description
//       trailing: Container(
//         height: 50.0,
//         width: MediaQuery.of(context).size.width / 4.5,
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(bottom: 5.0),
//               child: BookingInfoText(snack.price),
//             ),
//             TicketPriceView(),
//           ],
//         ),
//       ),
//     );
//   }
// }

void _navigateToConfirmPaymentPage(
  BuildContext context,
  CinemaVO cinema,
  List<SeatPlanVO> selectedSeats,
  int totalPrice,
  MovieDetailVO movie,
  DateVO selectedDate,
) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ConfirmPaymentPage(
          cinema, selectedSeats, totalPrice, movie, selectedDate, snackList),
    ),
  );
}

class PromoAndSubTotalView extends StatelessWidget {
  final int totalPrice;
  PromoAndSubTotalView(this.totalPrice);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              hintStyle: TextStyle(
                color: ComboSet_details_color,
                fontWeight: FontWeight.w400,
                fontSize: Regular_margin_size_1X,
                fontStyle: FontStyle.italic,
              ),
            ),
            style: TextStyle(
              color: ComboSet_details_color,
            ),
          ),
          SizedBox(
            height: Regular_margin_size,
          ),
          Row(
            children: [
              BookingInfoTextDetails(
                "Don't have any promo code ? ",
              ),
              Text(
                "Get it now",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: Subtitle_text_size,
                ),
              ),
            ],
          ),
          SizedBox(
            height: Regular_margin_size,
          ),
          Text(
            "Sub total : $totalPrice\$",
            style: TextStyle(color: Subtotal_text_color, fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}

class PaymentMethodView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MovieLabelText("Payment method"),
          SizedBox(
            height: Regular_margin_size,
          ),
          PaymentmethodInfoView(
            Icon(
              Icons.credit_card,
              color: Payment_icon_color,
            ),
            "Credit card",
            "Visa,master card,JCB",
          ),
          SizedBox(
            height: Regular_margin_size,
          ),
          PaymentmethodInfoView(
            Icon(
              Icons.credit_card,
              color: Payment_icon_color,
            ),
            "International banking (ATM card)",
            "Visa,master card,JCB",
          ),
          SizedBox(
            height: Regular_margin_size,
          ),
          PaymentmethodInfoView(
            Icon(
              Icons.account_balance_wallet,
              color: Payment_icon_color,
            ),
            "E-wallet",
            "Paypal",
          ),
        ],
      ),
    );
  }
}

class PaymentmethodInfoView extends StatelessWidget {
  final Icon icon;
  final String bInfoText;

  final String bInfoTextDetail;

  PaymentmethodInfoView(
    this.icon,
    this.bInfoText,
    this.bInfoTextDetail,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(
          width: Regular_margin_size,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BookingInfoText(
              bInfoText,
            ),
            BookingInfoTextDetails(
              bInfoTextDetail,
            ),
          ],
        ),
      ],
    );
  }
}

// class TicketPriceView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           Row(
//             children: [
//               AdjustPriceBtn("-", ComboSet_text_color),
//               AdjustPriceBtn("0", ComboSet_details_color),
//               AdjustPriceBtn("+", ComboSet_text_color),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
