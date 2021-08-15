// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'facebook_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _FaceBookApi implements FaceBookApi {
  _FaceBookApi(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://graph.facebook.com';
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
}
