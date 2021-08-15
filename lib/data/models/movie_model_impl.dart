import 'package:MovieBookingApplication/data/models/movie_model.dart';
import 'package:MovieBookingApplication/data/vo/card_vo.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/facebook_data_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:MovieBookingApplication/data/vo/snack_vo.dart';
import 'package:MovieBookingApplication/network/movie_data_agent.dart';
import 'package:MovieBookingApplication/network/responses/checkout_response.dart';
import 'package:MovieBookingApplication/network/requests/check_out_request.dart';
import 'package:MovieBookingApplication/network/responses/log_out_response.dart';
import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/network/responses/profile_response.dart';
import 'package:MovieBookingApplication/network/retrofit_data_agent_impl.dart';
import 'package:MovieBookingApplication/persistance/dao/cinema_dao.dart';
import 'package:MovieBookingApplication/persistance/dao/login_data_response_dao.dart';
import 'package:MovieBookingApplication/persistance/dao/movie_dao.dart';
import 'package:MovieBookingApplication/persistance/dao/snack_dao.dart';
import 'package:MovieBookingApplication/persistance/dao/userdata_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class MovieModelImpl extends MovieModel {
  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl() {
    return _singleton;
  }

  MovieModelImpl._internal();

  // Daos

  LoginDataResponseDao loginDao = LoginDataResponseDao();
  MovieDao mMovieDao = MovieDao();
  CinemaDao cinemaDao = CinemaDao();
  SnackDao snackDao = SnackDao();
  UserDataDao profileDao = UserDataDao();
  // GenreDao mGenreDao = GenreDao();
  // ActorDao mActorDao = ActorDao();

  @override
  Future<FacebookDataVO> getFacebookProfileData(String token) {
    return mDataAgent.getFacebookProfileData(token);
  }

  @override
  void getNowPlayingMovieList(String status) {
    mDataAgent.getMovieList(status).then((movies) async {
      List<MovieVO> movieLists = movies.map((movie) {
        movie.isNowPlaying = true;
        movie.isComingSoon = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(movieLists);
      // return Future.value(movies);
    });
  }

  @override
  void getComingSoonMovieList(String status) {
    mDataAgent.getMovieList(status).then((movies) async {
      List<MovieVO> movieLists = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isComingSoon = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(movieLists);
      // return Future.value(movies);
    });
  }

  @override
  void getMovieDetails(int id) {
    // TODO: implement getMovieDetails
    mDataAgent.getMovieDetails(id).then((movie) async {
      mMovieDao.saveSingleMovie(movie);
      // return Future.value(movie);
    });
  }

  @override
  void getCinemaTimeSlotList(String token, String date) {
    mDataAgent.getCinemaTimeSlotList(token, date).then((cinema) async {
      List<CinemaVO> cinemaList = cinema.map((cinema) {
        return cinema;
      }).toList();
      cinemaDao.saveCinemas(cinemaList, date);
      // return Future.value(movies);
    });
  }

  @override
  Future<LoginDataResponse> emailLogin(String email, String password) {
    return mDataAgent.emailLogin(email, password).then((value) async {
      loginDao.saveLoginDataResponse(value);
      return Future.value(value);
    });
  }

  @override
  Future<List<List<SeatPlanVO>>> getSeatPlan(
      String token, int timeSlotId, String bookingDate) {
    return mDataAgent.getSeatPlan(token, timeSlotId, bookingDate);
  }

  @override
  Future<LoginDataResponse> register(
      String name, String email, String phone, String password,
      {String facebookAccessToken, String googleAccessToken}) {
    return mDataAgent
        .register(name, email, phone, password,
            facebookAccessToken: facebookAccessToken,
            googleAccessToken: googleAccessToken)
        .then((value) async {
      loginDao.saveLoginDataResponse(value);
      return Future.value(value);
    });
  }

  @override
  Future<LogOutResponse> getLogOut(String token) {
    return mDataAgent.getLogOut(token);
  }

  @override
  void getSnacks(String token) {
    mDataAgent.getSnacks(token).then((snacks) async {
      List<SnackVO> snackList = snacks.map((snack) {
        return snack;
      }).toList();
      snackDao.saveSnackLists(snackList);
    });
  }

  @override
  Future<List<CardVO>> addNewCard(String token, String cardNumber,
      String cardHolder, String expDate, String cvc) {
    return mDataAgent.addNewCard(token, cardNumber, cardHolder, expDate, cvc);
  }

  @override
  void getProfileData(String token) {
    mDataAgent.getUserProfile(token).then((profile) async {
      profileDao.saveUserData(profile);
    });
  }
  // Database

  @override
  Stream<LoginDataResponse> getLoginDataFromDatabase() {
    return loginDao
        .getUserDataEventStream()
        .startWith(loginDao.getUserDataStream(1))
        .map((event) => loginDao.getLoginData(1));
  }

  ///Reactive login and register from

  // @override
  // Stream<LoginDataResponse> getLoginWithEmailDataFromDatabase(
  //     String email, String password) {
  //   this.emailLogin(email, password);
  //   return loginDao
  //       .getUserDataEventStream()
  //       .startWith(loginDao.getUserDataStream(1))
  //       .map((event) => loginDao.getLoginData(1));
  // }

  // @override
  // Stream<LoginDataResponse> getLoginWithFacebookDataFromDatabase(
  //     String accessToken) {
  //   this.facebookLogin(accessToken);
  //   return loginDao
  //       .getUserDataEventStream()
  //       .startWith(loginDao.getUserDataStream(1))
  //       .map((event) => loginDao.getLoginData(1));
  // }

  // @override
  // Stream<LoginDataResponse> getLoginWithGoogleDataFromDatabase(
  //     String accessToken) {
  //   this.googleLogin(accessToken);
  //   return loginDao
  //       .getUserDataEventStream()
  //       .startWith(loginDao.getUserDataStream(1))
  //       .map((event) => loginDao.getLoginData(1));
  // }

  // @override
  // Stream<LoginDataResponse> getRegisterDataFromDatabase(
  //     String name, String email, String phone, String password,
  //     {String facebookAccessToken, String googleAccessToken}) {
  //   this.register(name, email, phone, password,
  //       facebookAccessToken: facebookAccessToken,
  //       googleAccessToken: googleAccessToken);
  //   return loginDao
  //       .getUserDataEventStream()
  //       .startWith(loginDao.getUserDataStream(1))
  //       .map((event) => loginDao.getLoginData(1));
  // }

  // @override
  // Stream<LoginDataResponse> getLoginWithEmailDataFromDatabase(
  //     String email, String password) {
  //   this.emailLogin(email, password);
  //   return loginDao
  //       .getUserDataEventStream()
  //       .startWith(loginDao.getUserDataStream(1))
  //       .map((event) => loginDao.getLoginData(1));
  // }

  // @override
  // Stream<LoginDataResponse> getLoginWithFacebookDataFromDatabase(
  //     String accessToken) {
  //   this.facebookLogin(accessToken);
  //   return loginDao
  //       .getUserDataEventStream()
  //       .startWith(loginDao.getUserDataStream(1))
  //       .map((event) => loginDao.getLoginData(1));
  // }

  // @override
  // Stream<LoginDataResponse> getLoginWithGoogleDataFromDatabase(
  //     String accessToken) {
  //   this.googleLogin(accessToken);
  //   return loginDao
  //       .getUserDataEventStream()
  //       .startWith(loginDao.getUserDataStream(1))
  //       .map((event) => loginDao.getLoginData(1));
  // }

  // @override
  // Stream<LoginDataResponse> getRegisterDataFromDatabase(
  //     String name, String email, String phone, String password,
  //     {String facebookAccessToken, String googleAccessToken}) {
  //   this.register(name, email, phone, password,
  //       facebookAccessToken: facebookAccessToken,
  //       googleAccessToken: googleAccessToken);
  //   return loginDao
  //       .getUserDataEventStream()
  //       .startWith(loginDao.getUserDataStream(1))
  //       .map((event) => loginDao.getLoginData(1));
  // }
  // @override
  // Future<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
  //   this.getNowPlayingMovieList("current");
  //   return mMovieDao
  //       .getAllMoviesEventStream()
  //       .startWith(mMovieDao.getNowPlayingMoviesStream())
  //       .combineLatest(mMovieDao.getNowPlayingMoviesStream(),
  //           (event, movieList) => movieList as List<MovieVO>)
  //       .first;
  // }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovieList("current");
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies());
  }

  // @override
  // Future<List<MovieVO>> getComingSoonMoviesFromDatabase() {
  //   this.getComingSoonMovieList("comingsoon");
  //   return mMovieDao
  //       .getAllMoviesEventStream()
  //       .startWith(mMovieDao.getComingSoonMoviesStream())
  //       .combineLatest(mMovieDao.getComingSoonMoviesStream(),
  //           (event, movieList) => movieList as List<MovieVO>)
  //       .first;
  // }

  Stream<List<MovieVO>> getComingSoonMoviesFromDatabase() {
    this.getComingSoonMovieList("comingsoon");
    return mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getComingSoonMoviesStream())
        .map((event) => mMovieDao.getComingSoonMovies());
  }

  // @override
  // Future<MovieDetailVO> getSigleMovieFromDatabase(int movieId) {
  //   this.getMovieDetails(movieId);
  //   return mMovieDao
  //       .getSingleMovieEventStream()
  //       .startWith(mMovieDao.getSingleMovieStream(movieId))
  //       .combineLatest(mMovieDao.getSingleMovieStream(movieId),
  //           (event, movie) => movie as MovieDetailVO)
  //       .first;
  // }

  // @override
  // Future<MovieDetailVO> getSigleMovieFromDatabase(int movieId) {
  //   this.getMovieDetails(movieId);
  //   return mMovieDao
  //       .getSingleMovieEventStream()
  //       .startWith(mMovieDao.getSingleMovieStream(movieId))
  //       .combineLatest(mMovieDao.getSingleMovieStream(movieId),
  //           (event, movie) => movie as MovieDetailVO)
  //       .first;
  // }

  @override
  Stream<MovieDetailVO> getSigleMovieFromDatabase(int movieId) {
    this.getMovieDetails(movieId);
    return mMovieDao
        .getSingleMovieEventStream()
        .startWith(mMovieDao.getSingleMovieStream(movieId))
        .map((event) => mMovieDao.getMovieDetail(movieId));
  }

  @override
  Stream<ProfileResponse> getProfileDataFromDatabase(String token) {
    this.getProfileData(token);
    return profileDao
        .getUserDataEventStream()
        .startWith(profileDao.getUserDataStream(1))
        .map((event) => profileDao.getUserData(1));
  }
  // @override
  // Future<List<CinemaVO>> getCinemaTimeSlotListFromDatabase(
  //     String token, String date) {
  //   this.getCinemaTimeSlotList(token, date);
  //   return cinemaDao
  //       .getAllCinemasEventStream()
  //       .startWith(cinemaDao.getAllCinemasStream())
  //       .combineLatest(cinemaDao.getAllCinemasStream(),
  //           (event, cinemaList) => cinemaList as List<CinemaVO>)
  //       .first;
  // }

  //   @override
  // Future<List<CinemaVO>> getCinemaTimeSlotListFromDatabase(
  //     String token, String date) {
  //   this.getCinemaTimeSlotList(token, date);
  //   return cinemaDao
  //       .getAllCinemasEventStream()
  //       .startWith(cinemaDao.getAllCinemasStream())
  //       .combineLatest(cinemaDao.getAllCinemasStream(),
  //           (event, cinemaList) => cinemaList as List<CinemaVO>)
  //       .first;
  // }

  @override
  Stream<List<CinemaVO>> getCinemaTimeSlotListFromDatabase(
      String token, String date) {
    this.getCinemaTimeSlotList(token, date);
    return cinemaDao
        .getAllCinemasEventStream()
        .startWith(cinemaDao.getAllCinemasStream(date))
        .map((event) => cinemaDao.getAllCinemasByDate(date));
  }

  @override
  Stream<List<SnackVO>> getSnacksFromDatabase(String token) {
    this.getSnacks(token);
    return snackDao
        .getAllSnacksEventStream()
        .startWith(snackDao.getAllSnacksStream())
        .map((event) => snackDao.getSnackList());
  }

  @override
  Future<LoginDataResponse> facebookLogin(String accessToken) {
    return mDataAgent.facebookLogin(accessToken).then((value) async {
      loginDao.saveLoginDataResponse(value);
      return Future.value(value);
    });
  }

  @override
  Future<LoginDataResponse> googleLogin(String accessToken) {
    return mDataAgent.googleLogin(accessToken).then((value) async {
      loginDao.saveLoginDataResponse(value);
      return Future.value(value);
    });
  }

  @override
  Future<CheckoutResponse> checkOut(
      String token, CheckOutRequest checkOutRequest) {
    return mDataAgent.checkOut(token, checkOutRequest);
  }
  // @override
  // Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
  //   return Future.value(mMovieDao.getMovieById(movieId));
  // }

}
