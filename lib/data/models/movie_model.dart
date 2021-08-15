import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/facebook_data_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:MovieBookingApplication/data/vo/snack_vo.dart';
import 'package:MovieBookingApplication/data/vo/user_data_vo.dart';
import 'package:MovieBookingApplication/network/requests/check_out_request.dart';
import 'package:MovieBookingApplication/network/responses/checkout_response.dart';
import 'package:MovieBookingApplication/network/responses/log_out_response.dart';
import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/data/vo/card_vo.dart';
import 'package:MovieBookingApplication/network/responses/profile_response.dart';

abstract class MovieModel {
  //Network
  Future<FacebookDataVO> getFacebookProfileData(String token);
  void getNowPlayingMovieList(String status);
  void getComingSoonMovieList(String status);
  void getMovieDetails(int id);
  void getCinemaTimeSlotList(String token, String date);
  Future<LoginDataResponse> emailLogin(String email, String password);
  Future<LoginDataResponse> facebookLogin(String accessToken);
  Future<LoginDataResponse> googleLogin(String accessToken);
  Future<LoginDataResponse> register(
      String name, String email, String phone, String password,
      {String facebookAccessToken, String googleAccessToken});
  Future<List<List<SeatPlanVO>>> getSeatPlan(
      String token, int timeSlotId, String bookingDate);
  Future<LogOutResponse> getLogOut(String token);
  void getSnacks(String token);
  Future<List<CardVO>> addNewCard(String token, String cardNumber,
      String cardHolder, String expDate, String cvc);
  Future<CheckoutResponse> checkOut(
      String token, CheckOutRequest checkOutRequest);
  void getProfileData(String token);

  //Database
  // Stream<LoginDataResponse> getLoginWithEmailDataFromDatabase(
  //     String email, String password);
  // Stream<LoginDataResponse> getLoginWithFacebookDataFromDatabase(
  //     String accessToken);
  // Stream<LoginDataResponse> getLoginWithGoogleDataFromDatabase(
  //     String accessToken);
  // Stream<LoginDataResponse> getRegisterDataFromDatabase(
  //     String name, String email, String phone, String password,
  //     {String facebookAccessToken, String googleAccessToken});
  Stream<LoginDataResponse> getLoginDataFromDatabase();
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase();
  Stream<List<MovieVO>> getComingSoonMoviesFromDatabase();
  Stream<MovieDetailVO> getSigleMovieFromDatabase(int movieId);
  Stream<List<CinemaVO>> getCinemaTimeSlotListFromDatabase(
      String token, String date);
  Stream<List<SnackVO>> getSnacksFromDatabase(String token);
  Stream<ProfileResponse> getProfileDataFromDatabase(String token);
}
