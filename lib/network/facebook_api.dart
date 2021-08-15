// import 'package:MovieBookingApplication/network/responses/cinema_list_response.dart';
import 'package:MovieBookingApplication/network/responses/add_new_card_response.dart';
import 'package:MovieBookingApplication/network/responses/cinema_time_slot_list_response.dart';
import 'package:MovieBookingApplication/network/responses/log_out_response.dart';
import 'package:MovieBookingApplication/network/responses/login_data_response.dart';
import 'package:MovieBookingApplication/network/responses/seat_plan_response.dart';
import 'package:MovieBookingApplication/network/responses/snack_response.dart';
import 'package:dio/dio.dart';
import 'package:MovieBookingApplication/data/vo/facebook_data_vo.dart';
import 'package:MovieBookingApplication/data/vo/movie_detail_vo.dart';
import 'package:MovieBookingApplication/network/api_constants.dart';
import 'package:MovieBookingApplication/network/responses/movie_detail_response.dart';
import 'package:MovieBookingApplication/network/responses/movie_list_response.dart';
import 'package:retrofit/http.dart';

part 'facebook_api.g.dart';

@RestApi(baseUrl: FACEBOOK_BASE_URL_DIO)
abstract class FaceBookApi {
  factory FaceBookApi(Dio dio) = _FaceBookApi;

  @GET(ENDPOINT_GET_FACEBOOK_DATA)
  Future<FacebookDataVO> getFacebookProfileData(
    @Query(PARAM_Fields) String fields,
    @Query(PARAM_ACCESS_TOKEN) String accessToken,
  );
}
