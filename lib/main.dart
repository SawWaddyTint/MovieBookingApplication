import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/models/movie_model_impl.dart';
import 'package:MovieBookingApplication/data/vo/card_vo.dart';
import 'package:MovieBookingApplication/data/vo/cast_vo.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:MovieBookingApplication/data/vo/snack_vo.dart';
import 'package:MovieBookingApplication/data/vo/time_slot_vo.dart';
import 'package:MovieBookingApplication/data/vo/user_data_vo.dart';
import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/network/responses/profile_response.dart';
import 'package:MovieBookingApplication/pages/login_page.dart';
import 'package:MovieBookingApplication/pages/movie_choose_time_page.dart';
import 'package:MovieBookingApplication/pages/movie_lists_page.dart';
import 'package:MovieBookingApplication/persistance/hive_constants.dart';
import 'package:MovieBookingApplication/utility_function.dart';
import 'package:flutter/material.dart';
import 'package:MovieBookingApplication/pages/welcome_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/vo/movie_vo.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserDataVOAdapter());
  Hive.registerAdapter(CardVOAdapter());
  Hive.registerAdapter(LoginDataResponseAdapter());
  Hive.registerAdapter(MovieVOAdapter());
  Hive.registerAdapter(MovieDetailVOAdapter());
  Hive.registerAdapter(CastVOAdapter());
  Hive.registerAdapter(CinemaVOAdapter());
  Hive.registerAdapter(TimeSlotVOAdapter());
  Hive.registerAdapter(SnackVOAdapter());
  Hive.registerAdapter(ProfileResponseAdapter());
  // Hive.registerAdapter(UserDataVOAdapter());
  // Hive.registerAdapter(CardVOAdapter());
  // Hive.registerAdapter(LoginDataResponseAdapter());
  //
  await Hive.openBox<LoginDataResponse>(BOX_NAME_LOGIN_DATA_RESPONSE_VO);
  await Hive.openBox<MovieVO>(BOX_NAME_MOVIE_VO);
  await Hive.openBox<MovieDetailVO>(BOX_NAME_MOVIE_DETAIL_VO);
  await Hive.openBox<CinemaVO>(BOX_NAME_CINEMA_VO);
  await Hive.openBox<TimeSlotVO>(BOX_NAME_TIME_SLOT_VO);
  await Hive.openBox<SnackVO>(BOX_NAME_SNACK_VO);
  await Hive.openBox<ProfileResponse>(BOX_NAME_PROFILE_VO);

  // await Hive.openBox<GenreVO>(BOX_NAME_GENRE_VO);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MovieModel mMovieModel = MovieModelImpl();
  String token = "";
  @override
  void initState() {
    super.initState();
    //get token from database
    mMovieModel.getLoginDataFromDatabase().listen((value) {
      setState(() {
        token = value.token;
      });
    }).onError((error) {
      handleError(context, error);
    });
    // mMovieModel.getSigleMovieFromDatabase().then((value) {
    //   MovieDetailVO movie = value;
    //   debugPrint("movie is >>>" + movie.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primarySwatch: Colors.white,
        primaryColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      home: (token != "" && token != null) ? MovieListsPage() : LoginPage(),
      // home: MovieListsPage(),
      // home: MovieDetailsPage(),
      // home: TicketDetailsPage(),
      // home: MovieSeatsPage(),
      // home: MovieChooseTimePage(),
    );
  }
}
