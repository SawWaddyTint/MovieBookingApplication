import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/check_out_vo.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/date_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:MovieBookingApplication/network/api_constants.dart';
import 'package:MovieBookingApplication/pages/movie_lists_page.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/resources/colors.dart';
import 'package:MovieBookingApplication/resources/dimens.dart';
import 'package:MovieBookingApplication/widgets/form_field_name.dart';

import '../utility_function.dart';

class PayslipPage extends StatefulWidget {
  final CheckOutVO checkOutData;
  final DateVO selectedDate;
  final CinemaVO cinema;
  final MovieDetailVO movie;
  PayslipPage(this.checkOutData, this.selectedDate, this.cinema, this.movie);

  @override
  _PayslipPageState createState() => _PayslipPageState();
}

class _PayslipPageState extends State<PayslipPage> {
  MovieModel mMovieModel = MovieModelImpl();
  MovieDetailVO movie;
  @override
  void initState() {
    super.initState();
    setState(() {
      mMovieModel
          .getSigleMovieFromDatabase(widget.checkOutData.movieId)
          .listen((value) {
        movie = value;
      }).onError((error) {
        handleError(context, error);
        // debugPrint(error.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: Small_margin_size,
            right: Small_margin_size,
            top: Small_margin_size,
          ),
          child: GestureDetector(
            child: Icon(
              Icons.close,
              color: Colors.black,
              size: Medium_title_text_size,
            ),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (c) => MovieListsPage()),
                  (route) => false);
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Small_margin_size,
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: Regular_margin_size_2X),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                PayslipTitleView(),
                MoviePosterAndDurationView(movie),
                // SizedBox(
                //   height: 0.0,
                // ),
                PaySlipInfoView(
                    widget.checkOutData, widget.selectedDate, widget.cinema),
                BarcodeView(),
                SizedBox(
                  height: XXS_margin_size,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BarcodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Xs_margin_size),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 47.0,
            right: 47.0,
            bottom: 15.0,
            top: Small_margin_size,
          ),
          child: BarCodeImage(
            params: Code39BarCodeParams(
              "1234ABCD",
              lineWidth:
                  1.7, // width for a single black/white bar (default: 2.0)
              barHeight:
                  Barcode_height, // height for the entire widget (default: 100.0)
              // Render with text label or not (default: false)
            ),
            onError: (error) {
              // Error handler
              print('error = $error');
            },
          ),
        ),
      ),
    );
  }
}

class PaySlipInfoView extends StatefulWidget {
  final CheckOutVO checkOutData;
  final DateVO selectedDate;
  final CinemaVO cinema;

  PaySlipInfoView(this.checkOutData, this.selectedDate, this.cinema);

  @override
  _PaySlipInfoViewState createState() => _PaySlipInfoViewState();
}

class _PaySlipInfoViewState extends State<PaySlipInfoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 350,
      margin: EdgeInsets.only(
        left: XXS_margin_size,
        right: XXS_margin_size,
      ),
      // margin: EdgeInsets.all(8.0),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 0.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Xs_margin_size),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            right: Small_margin_size,
            left: Small_margin_size,
            top: Regular_margin_size_2X,
          ),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PayslipInfo("Booking no", widget.checkOutData.bookingNo),
              SizedBox(height: Small_sizebox_height),
              PayslipInfo("Show time - Date",
                  "${widget.checkOutData.timeSlotVO.startTime} - ${widget.selectedDate.date} ${widget.selectedDate.day}"),
              SizedBox(height: Small_sizebox_height),
              PayslipInfo("Theater", widget.cinema.name),
              SizedBox(height: Small_sizebox_height),
              PayslipInfo("Screen", "2"),
              SizedBox(height: Small_sizebox_height),
              PayslipInfo(
                  "Row",
                  // widget.selectedSeatLists.map((seat) => seat.symbol).join(","),
                  widget.checkOutData.row),
              SizedBox(height: Small_sizebox_height),
              PayslipInfo(
                  "Seat\ns",
                  // widget.selectedSeatLists.map((seat) => seat.seatName).join(","),
                  widget.checkOutData.seat),
              SizedBox(height: Small_sizebox_height),
              PayslipInfo("Price", widget.checkOutData.total),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: const MySeparator(
                    color: Color.fromRGBO(217, 217, 217, 1.0)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoviePosterAndDurationView extends StatelessWidget {
  final MovieDetailVO movie;
  MoviePosterAndDurationView(this.movie);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: XXS_margin_size,
        right: XXS_margin_size,
        top: Small_margin_size,
      ),
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 0.0,
        ),
        // elevation: 0.45,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(Xs_margin_size),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Xs_margin_size),
                topRight: Radius.circular(Xs_margin_size),
              ),
              child: Image.network('$IMAGE_BASE_URL${movie.posterPath}',
                  // width: 300,
                  height: Toolbar_height,
                  fit: BoxFit.cover),
            ),
            ListTile(
              title: Text(
                movie.originalTitle,
                style: TextStyle(
                  color: ComboSet_text_color,
                  fontWeight: FontWeight.w400,
                  fontSize: Regular_title_text_size,
                ),
              ),
              subtitle: Text(
                "${movie.runtime} mins",
                style: TextStyle(
                  color: Welcome_logIn_subTitle_color,
                  fontWeight: FontWeight.w400,
                  fontSize: Regular_title_text_size,
                ),
              ),
            ),
            const MySeparator(color: Color.fromRGBO(217, 217, 217, 1.0)),
          ],
        ),
      ),
    );
  }
}

class PayslipTitleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Awesome!",
            style: TextStyle(
              fontSize: 27.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 6.0,
          ),
          Text(
            "This is your ticket",
            style: TextStyle(
              color: Welcome_logIn_subTitle_color,
              fontWeight: FontWeight.w400,
              fontSize: Regular_title_text_size,
            ),
          ),
        ],
      ),
    );
  }
}

class PayslipInfo extends StatefulWidget {
  final String label;
  final String desc;
  PayslipInfo(this.label, this.desc);

  @override
  _PayslipInfoState createState() => _PayslipInfoState();
}

class _PayslipInfoState extends State<PayslipInfo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FormFieldName(widget.label),
        Spacer(),
        PayslipDetailsInfoText(widget.desc),
      ],
    );
  }
}

class PayslipDetailsInfoText extends StatelessWidget {
  final String text;
  PayslipDetailsInfoText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: Subtitle_text_size,
        color: Color.fromRGBO(71, 77, 87, 1.0),
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final double height;
  final Color color;

  const MySeparator({this.height = 1.2, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 8.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
