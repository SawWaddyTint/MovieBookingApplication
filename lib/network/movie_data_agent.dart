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
import 'package:MovieBookingApplication/network/responses/profile_response.dart';
import 'package:MovieBookingApplication/network/responses/seat_plan_response.dart';
import 'package:MovieBookingApplication/data/vo/card_vo.dart';

abstract class MovieDataAgent {
  Future<FacebookDataVO> getFacebookProfileData(String token);
  Future<List<MovieVO>> getMovieList(String status);
  Future<MovieDetailVO> getMovieDetails(int movieId);
  Future<List<CinemaVO>> getCinemaTimeSlotList(String token, String date);
  Future<LoginDataResponse> emailLogin(String email, String password);
  Future<LoginDataResponse> facebookLogin(String accessToken);
  Future<LoginDataResponse> googleLogin(String accessToken);
  Future<LoginDataResponse> register(
      String name, String email, String phone, String password,
      {String facebookAccessToken, String googleAccessToken});
  Future<List<List<SeatPlanVO>>> getSeatPlan(
      String token, int timeSlotId, String bookingDate);
  Future<LogOutResponse> getLogOut(String token);
  Future<List<SnackVO>> getSnacks(String token);
  Future<List<CardVO>> addNewCard(String token, String cardNumber,
      String cardHolder, String expDate, String cvc);
  Future<CheckoutResponse> checkOut(
      String token, CheckOutRequest checkOutRequest);
  Future<ProfileResponse> getUserProfile(String token);
}
