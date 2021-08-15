// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'the_movie_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _TheMovieApi implements TheMovieApi {
  _TheMovieApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://tmba.padc.com.mm';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<FacebookDataVO> getFacebookProfileData(fields, accessToken) async {
    ArgumentError.checkNotNull(fields, 'fields');
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'fields': fields,
      r'access_token': accessToken
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/v2.12/me',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FacebookDataVO.fromJson(_result.data);
    return value;
  }

  @override
  Future<MovieListResponse> getMovieList(status) async {
    ArgumentError.checkNotNull(status, 'status');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'status': status};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/movies',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MovieListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<MovieDetailResponse> getMovieDetails(movieId) async {
    ArgumentError.checkNotNull(movieId, 'movieId');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/movies/$movieId',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = MovieDetailResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CinemaTimeSlotListResponse> getCinemaTimeSlotList(token, date) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(date, 'date');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'date': date};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/cinema-day-timeslots',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CinemaTimeSlotListResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SeatPlanResponse> getSeatPlan(token, timeSlotId, bookingDate) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(timeSlotId, 'timeSlotId');
    ArgumentError.checkNotNull(bookingDate, 'bookingDate');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'cinema_day_timeslot_id': timeSlotId,
      r'booking_date': bookingDate
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/seat-plan',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SeatPlanResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginDataResponse> emailLogin(email, password) async {
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'email': email, 'password': password};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/email-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = LoginDataResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginDataResponse> facebookLogin(accessToken) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'access-token': accessToken};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/facebook-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = LoginDataResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginDataResponse> googleLogin(accessToken) async {
    ArgumentError.checkNotNull(accessToken, 'accessToken');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {'access-token': accessToken};
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/api/v1/google-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = LoginDataResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LoginDataResponse> register(name, email, phone, password,
      {facebookAccessToken, googleAccessToken}) async {
    ArgumentError.checkNotNull(name, 'name');
    ArgumentError.checkNotNull(email, 'email');
    ArgumentError.checkNotNull(phone, 'phone');
    ArgumentError.checkNotNull(password, 'password');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    queryParameters.removeWhere((k, v) => v == null);
    final _data = {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'facebook-access-token': facebookAccessToken,
      'google-access-token': googleAccessToken
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/register',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = LoginDataResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<LogOutResponse> getLogOut(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/logout',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = LogOutResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<SnackResponse> getSnacks(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/snacks',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = SnackResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<AddNewCardResponse> addNewCard(
      token, cardNumber, cardHolder, expirationDate, cvc) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(cardNumber, 'cardNumber');
    ArgumentError.checkNotNull(cardHolder, 'cardHolder');
    ArgumentError.checkNotNull(expirationDate, 'expirationDate');
    ArgumentError.checkNotNull(cvc, 'cvc');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = {
      'card_number': cardNumber,
      'card_holder': cardHolder,
      'expiration_date': expirationDate,
      'cvc': cvc
    };
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/card',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = AddNewCardResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<CheckoutResponse> checkOut(token, checkOutRequest) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(checkOutRequest, 'checkOutRequest');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(checkOutRequest?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/checkout',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = CheckoutResponse.fromJson(_result.data);
    return value;
  }

  @override
  Future<ProfileResponse> getUserProfile(token) async {
    ArgumentError.checkNotNull(token, 'token');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('/api/v1/profile',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ProfileResponse.fromJson(_result.data);
    return value;
  }
}
