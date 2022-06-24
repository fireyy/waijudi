import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:waijudi/util/encrypt.dart';

import 'package:waijudi/model/api_response.dart';
import 'package:waijudi/model/searchresult.dart';
import 'package:waijudi/model/categroy.dart';

var options = BaseOptions(
  baseUrl: 'https://waijudi.ywhuilong.com',
  connectTimeout: 5000,
  receiveTimeout: 3000,
  headers: {
    'token': '14f2e846-6b31-460b-9ebc-34006a0ce0b1' //TODO: renew token
  },
  contentType: Headers.formUrlEncodedContentType,
  // responseType: ResponseType.plain,
);

class ApiClient {
  static final _client = ApiClient._internal();
  final _http = Dio(options);

  ApiClient._internal();

  factory ApiClient() => _client;

  Future<dynamic> _post (String uri, { Map? params }) async {
    Map<String, dynamic> body = params != null ? {
      'params': sign(params)
    } : {};
    FormData formData = FormData.fromMap(body);
    var response = await _http.post(uri, data: formData);
    // var decodedResponse = ApiResponse.fromJson(response.data);
    // print(response.data);
    var decodedResponse = ApiResponse.fromJson(response.data);
    if (decodedResponse.code == 1) {
      return decodedResponse.data;
    } else {
      throw Exception(decodedResponse.msg);
    }
  }

  Future<SearchResult> getVideo (
      {int page = 1, int category = 0, int pageSize = 6}) async {
    var params = {'type_id': category, 'page': page, 'pageSize': pageSize};

    return _post('/web/video_home/getVideo', params: params).then((data) => SearchResult.fromJson(data));
  }

  Future<List<Categroy>> getNavigation (
      {int page = 1, int category = 0, int pageSize = 6}) async {

    return _post('/web/video_home/getNavigation').then((data) => (data as List).map((d) => Categroy.fromJson(d)).toList());
  }
}