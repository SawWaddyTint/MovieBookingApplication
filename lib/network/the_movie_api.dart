// import 'package:MovieBookingApplication/network/responses/cinema_list_response.dart';
import 'package:MovieBookingApplication/network/requests/check_out_request.dart';
import 'package:MovieBookingApplication/network/responses/add_new_card_response.dart';
import 'package:MovieBookingApplication/network/responses/checkout_response.dart';
import 'package:MovieBookingApplication/network/responses/cinema_time_slot_list_response.dart';
import 'package:MovieBookingApplication/network/responses/log_out_response.dart';
import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/network/responses/profile_response.dart';
import 'package:MovieBookingApplication/network/responses/seat_plan_response.dart';
import 'package:MovieBookingApplication/network/responses/snack_response.dart';
import 'package:dio/dio.dart';
import 'package:MovieBookingApplication/data/vo/facebook_data_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/network/api_constants.dart';
import 'package:MovieBookingApplication/network/responses/movie_detail_response.dart';
import 'package:MovieBookingApplication/network/responses/movie_list_response.dart';
import 'package:retrofit/http.dart';

part 'the_movie_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheMovieApi {
  factory TheMovieApi(Dio dio) = _TheMovieApi;

  @GET(ENDPOINT_GET_FACEBOOK_DATA)
  @Header(CONTENT_TYPE)
  Future<FacebookDataVO> getFacebookProfileData(
    @Query(PARAM_Fields) String fields,
    @Query(PARAM_ACCESS_TOKEN) String accessToken,
  );

  @GET(ENDPOINT_MOVIE)
  Future<MovieListResponse> getMovieList(
    @Query(PARAM_STATUS) String status,
  );

  @GET("$ENDPOINT_MOVIE/{movie_id}")
  Future<MovieDetailResponse> getMovieDetails(
    @Path("movie_id") int movieId,
  );

  @GET(ENDPOINT_CINEMA_TIME_SLOT)
  Future<CinemaTimeSlotListResponse> getCinemaTimeSlotList(
    @Header("Authorization") String token,
    @Query(PARAM_DATE) String date,
  );

  @GET(ENDPOINT_SEAT_PLAN)
  Future<SeatPlanResponse> getSeatPlan(
    @Header("Authorization") String token,
    @Query(PARAM_TIME_SLOT_ID) int timeSlotId,
    @Query(PARAM_BOOKING_DATE) String bookingDate,
  );

  @FormUrlEncoded()
  @POST(ENDPOINT_EMAIL_LOGIN)
  Future<LoginDataResponse> emailLogin(
    @Field("email") String email,
    @Field("password") String password,
  );

  @FormUrlEncoded()
  @POST(ENDPOINT_FACEBOOK_LOGIN)
  Future<LoginDataResponse> facebookLogin(
    @Field(PARAM_FB_GOOGLE_ACCESS_TOKEN) String accessToken,
  );

  @FormUrlEncoded()
  @POST(ENDPOINT_GOOGLE_LOGIN)
  Future<LoginDataResponse> googleLogin(
    @Field(PARAM_FB_GOOGLE_ACCESS_TOKEN) String accessToken,
  );

  @FormUrlEncoded()
  @POST(ENDPOINT_REGISTER)
  Future<LoginDataResponse> register(
      @Field(PARAM_NAME) String name,
      @Field(PARAM_EMAIL) String email,
      @Field(PARAM_PHONE) String phone,
      @Field(PARAM_PASSWORD) String password,
      {@Field(PARAM_FACEBOOK_ACCESS_TOKEN) String facebookAccessToken,
      @Field(PARAM_GOOGLE_ACCESS_TOKEN) String googleAccessToken});

  @POST(ENDPOINT_lOG_OUT)
  Future<LogOutResponse> getLogOut(
    @Header("Authorization") String token,
  );

  @GET(ENDPOINT_SNACKS)
  Future<SnackResponse> getSnacks(
    @Header("Authorization") String token,
  );

  @POST(ENDPOINT_ADD_NEW_CARD)
  Future<AddNewCardResponse> addNewCard(
    @Header("Authorization") String token,
    @Field(PARAM_CARD_NUMBER) String cardNumber,
    @Field(PARAM_CARD_HOLDER) String cardHolder,
    @Field(PARAM_EXPIRATION_DATE) String expirationDate,
    @Field(PARAM_CVC) String cvc,
  );

  @POST(ENDPOINT_CHECKOUT)
  Future<CheckoutResponse> checkOut(
    @Header(HEADER_AUTHORIZATION) String token,
    @Body() CheckOutRequest checkOutRequest,
  );

  @GET(ENDPOINT_PROFILE)
  Future<ProfileResponse> getUserProfile(
    @Header("Authorization") String token,
  );
}
