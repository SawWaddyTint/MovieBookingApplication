import 'package:MovieBookingApplication/data/vo/card_vo.dart';
import 'package:MovieBookingApplication/data/vo/cinema_vo.dart';
import 'package:MovieBookingApplication/data/vo/seat_plan_vo.dart';
import 'package:MovieBookingApplication/data/vo/snack_vo.dart';
import 'package:MovieBookingApplication/data/vo/user_data_vo.dart';
import 'package:MovieBookingApplication/network/responses/checkout_response.dart';
import 'package:MovieBookingApplication/network/requests/check_out_request.dart';
import 'package:MovieBookingApplication/network/responses/log_out_response.dart';
import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/network/responses/profile_response.dart';
import 'package:MovieBookingApplication/network/responses/seat_plan_response.dart';
import 'package:MovieBookingApplication/utility_function.dart';
import 'package:dio/dio.dart';
import 'package:MovieBookingApplication/data/vo/facebook_data_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_vo.dart';
import 'package:MovieBookingApplication/network/movie_data_agent.dart';
import 'package:MovieBookingApplication/network/responses/movie_detail_response.dart';
import 'package:MovieBookingApplication/network/the_movie_api.dart';
import 'package:MovieBookingApplication/network/facebook_api.dart';

import 'api_constants.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  TheMovieApi mApi;
  FaceBookApi fbApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();

    mApi = TheMovieApi(dio);
    fbApi = FaceBookApi(dio);
  }

  @override
  Future<FacebookDataVO> getFacebookProfileData(String token) {
    return fbApi.getFacebookProfileData(Fields, token);
  }

  @override
  Future<List<MovieVO>> getMovieList(String status) {
    return mApi
        .getMovieList(status)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<MovieDetailVO> getMovieDetails(int movieId) {
    return mApi.getMovieDetails(movieId).then((value) => value.data);
  }

  @override
  Future<List<CinemaVO>> getCinemaTimeSlotList(String token, String date) {
    return mApi
        .getCinemaTimeSlotList(token, date)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<LoginDataResponse> emailLogin(String email, String password) {
    return mApi.emailLogin(email, password).then((response) => response);
  }

  @override
  Future<List<List<SeatPlanVO>>> getSeatPlan(
      String token, int timeSlotId, String bookingDate) {
    return mApi
        .getSeatPlan(token, timeSlotId, bookingDate)
        .asStream()
        .map((response) => response.data)
        .first;
  }

  @override
  Future<LoginDataResponse> register(
      String name, String email, String phone, String password,
      {String facebookAccessToken, String googleAccessToken}) {
    return mApi
        .register(name, email, phone, password,
            facebookAccessToken: facebookAccessToken,
            googleAccessToken: googleAccessToken)
        .then((response) => response);
  }

  @override
  Future<LogOutResponse> getLogOut(String token) {
    return mApi.getLogOut(token).then((response) => response);
  }

  @override
  Future<List<SnackVO>> getSnacks(String token) {
    return mApi.getSnacks(token).then((response) => response.data);
  }

  @override
  Future<List<CardVO>> addNewCard(String token, String cardNumber,
      String cardHolder, String expDate, String cvc) {
    return mApi
        .addNewCard(token, cardNumber, cardHolder, expDate, cvc)
        .then((response) => response.data);
  }

  @override
  Future<LoginDataResponse> facebookLogin(String accessToken) {
    return mApi.facebookLogin(accessToken).then((response) => response);
  }

  @override
  Future<LoginDataResponse> googleLogin(String accessToken) {
    return mApi.googleLogin(accessToken).then((response) => response);
  }

  @override
  Future<CheckoutResponse> checkOut(
      String token, CheckOutRequest checkOutRequest) {
    return mApi.checkOut(token, checkOutRequest).then((response) => response);
  }

  @override
  Future<ProfileResponse> getUserProfile(String token) {
    return mApi.getUserProfile(token).then((value) => value);
  }
}
