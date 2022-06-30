import 'package:dio/dio.dart';
import 'package:waijudi/models/section.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/util/encrypt.dart';

import 'package:waijudi/models/api_response.dart';
import 'package:waijudi/models/searchresult.dart';
import 'package:waijudi/models/category.dart';
import 'package:waijudi/models/line.dart';
import 'package:waijudi/models/drama.dart';
import 'package:waijudi/models/filter.dart';

class ApiClient {
  static final _client = ApiClient._internal();
  final _http = ApiClient.createDio();

  ApiClient._internal();

  factory ApiClient() => _client;

  static Dio createDio() {
    var options = BaseOptions(
      baseUrl: 'https://waijudi.ywhuilong.com',
      connectTimeout: 15000,
      receiveTimeout: 3000,
      headers: {
        'token': '14f2e846-6b31-460b-9ebc-34006a0ce0b1' //TODO: renew token
      },
      contentType: Headers.formUrlEncodedContentType,
      // responseType: ResponseType.plain,
    );
    var dio = Dio(options);
    dio.interceptors.add(LogInterceptor(requestHeader: false, responseHeader: false));
    return dio;
  }

  Future<dynamic> _post (String uri, { Map? params }) async {
    FormData formData = FormData.fromMap(params != null ? {
      'params': sign(params)
    } : {});
    var response = await _http.post(uri, data: formData);
    // print(response.data);
    var decodedResponse = ApiResponse.fromJson(response.data);
    if (decodedResponse.code == 1) {
      return decodedResponse.data;
    } else {
      throw Exception(decodedResponse.msg);
    }
  }

  Future<dynamic> _get (String uri, { Map<String, dynamic>? params }) async {
    var response = await _http.get(uri, queryParameters: params ?? {});
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

  Future<List<Category>> getNavigation () async {
    return _post('/web/video_home/getNavigation').then((data) => (data as List).map((d) => Category.fromJson(d)).toList());
  }

  Future<SearchResultWithVideoItem> searchByFilter (FilterParams params) async {

    return _get('/web/vod_type/get', params: params.toJson()).then((data) => SearchResultWithVideoItem.fromJson(data));
  }

  Future<List<FilterModel>> getType () async {

    return _get('/web/vod_type/getType', params: {
      'pageSize': 99,
      'page': 1
    }).then((data) => (data as List).map((d) => FilterModel.fromJson(d)).toList());
  }

  Future<SearchResultWithVideoItem> searchByName (String name,
      {int page = 1, int pageSize = 20}) async {
    var params = {'name': name, 'page': page, 'pageSize': pageSize};

    return _get('/web/search_home/getHodVod', params: params).then((data) => SearchResultWithVideoItem.fromJson(data));
  }

  Future<List<LineModel>> getLine (int id) async {

    return _get('/web/video_home/line?pageSize=999&id=$id&page=0').then((data) => (data as List).map((d) => LineModel.fromJson(d)).toList());
  }

  Future<List<Drama>> getDramaDetail ({ int id = 0, int lineId = 0 }) async {

    return _get('/web/video_home/drama?vod_line_id=$lineId&id=$id&pageSize=999&page=0').then((data) => (data as List).map((d) => Drama.fromJson(d)).toList());
  }

  Future<String> vodDecrypt (String url) async {
    var params = {'url': url};
    return _get('/web/common/vodDecrypt', params: params).then((data) => data['url']);
  }
}