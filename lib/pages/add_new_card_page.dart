import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/card_vo.dart';
import 'package:MovieBookingApplication/pages/confirm_payment_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:MovieBookingApplication/pages/payslip_page.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/resources/strings.dart';
import 'package:MovieBookingApplication/widgets/app_action_btn.dart';
import 'package:MovieBookingApplication/widgets/form_field_name.dart';

import '../utility_function.dart';

TextEditingController cardNumber = TextEditingController();
TextEditingController cardHolder = TextEditingController();
TextEditingController expDate = TextEditingController();
TextEditingController cvc = TextEditingController();
bool isCardNumNull = false;
bool isCardHolderNull = false;
bool isExpDateNull = false;
bool isCvcNull = false;

class AddNewCardPage extends StatefulWidget {
  List<CardVO> cardLists1;

  AddNewCardPage(this.cardLists1);

  @override
  _AddNewCardPageState createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCardPage> {
  String token;
  MovieModel mMovieModel = MovieModelImpl();
  List<CardVO> newcardLists1;
  int flag;
  @override
  void initState() {
    super.initState();
    mMovieModel.getLoginDataFromDatabase().listen((value) {
      setState(() {
        token = value.token;
      });
    }).onError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  checkField(String cardNumber, String cardHolder, String expDate, String cvc) {
    setState(() {
      if (cardNumber == "") {
        setState(() {
          isCardNumNull = true;
        });
      } else
        isCardNumNull = false;

      if (cardHolder == "") {
        setState(() {
          isCardHolderNull = true;
        });
      } else
        isCardHolderNull = false;

      if (expDate == "") {
        setState(() {
          isExpDateNull = true;
        });
      } else
        isExpDateNull = false;

      if (cvc == "") {
        setState(() {
          isCvcNull = true;
        });
      } else
        isCvcNull = false;

      if (!isCardNumNull && !isCardHolderNull && !isExpDateNull && !isCvcNull) {
        this.addNewCard(cardNumber, cardHolder, expDate, cvc);
      }
    });
  }

  addNewCard(String cardNumber, String cardHolder, String expDate, String cvc) {
    mMovieModel
        .addNewCard('Bearer $token', cardNumber, cardHolder, expDate, cvc)
        .then((value) {
      // setState(() {
      newcardLists1 = value;
      if (newcardLists1.length > 0) {
        mMovieModel
            .getProfileDataFromDatabase('Bearer $token')
            .listen((profile) => profile);
        flag = 1;
        this._popToPreviousPage(context, newcardLists1: newcardLists1);
      }
      // });
    }).catchError((error) {
      handleError(context, error);
      // debugPrint(error.toString());
    });
  }

  _popToPreviousPage(BuildContext context, {List<CardVO> newcardLists1}) {
    Navigator.pop(context, newcardLists1);
    cardHolder.text = "";
    cardNumber.text = "";
    expDate.text = "";
    cvc.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onTap: () {
            this._popToPreviousPage(context);
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PaymentAmountView1(),
              SizedBox(
                height: Regular_margin_size,
              ),
              // CardSwipeView1(widget.cardLists1),
              SizedBox(height: Title_text_size),
              CardHolderInfoView1((cardNumber, cardHolder, expDate, cvc) {
                this.checkField(cardNumber, cardHolder, expDate, cvc);
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// void _navigateToPayslipPage(BuildContext context) {
//   Navigator.push(
//     context,
//     MaterialPageRoute(
//       builder: (context) => PayslipPage(),
//     ),
//   );
// }

class AddNewCardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
        )
      ],
    );
  }
}

class CardHolderInfoView1 extends StatelessWidget {
  final Function(String, String, String, String) addNewCard;
  CardHolderInfoView1(this.addNewCard);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Regular_margin_size_2X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormFieldName(Card_num_txt),
          TextField(
            controller: cardNumber,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: Medium_margin_size,
          ),
          FormFieldName(Card_holder_txt),
          TextField(
            controller: cardHolder,
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
                  controller: expDate,
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
                  controller: cvc,
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
          AddNewCardView(),
          SizedBox(
            height: Medium_margin_size,
          ),
          AppActionBtn(
            Confirm_txt,
            () {
              this.addNewCard(
                  cardNumber.text, cardHolder.text, expDate.text, cvc.text);
            },
          ),
          SizedBox(
            height: Regular_margin_size_2X,
          ),
        ],
      ),
    );
  }
}

class CardSwipeView1 extends StatelessWidget {
  final List<CardVO> cardList1;
  CardSwipeView1(this.cardList1);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: (cardList1 != null)
          ? CarouselSlider(
              options: CarouselOptions(
                  height: 400.0,
                  enlargeCenterPage: true,
                  initialPage: cardList1.length - 1),
              items: cardList1.map((card) {
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class PaymentAmountView1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
