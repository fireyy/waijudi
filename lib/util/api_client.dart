import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waijudi/util/encrypt.dart';

import 'package:waijudi/model/api_response.dart';
import 'package:waijudi/model/searchresult.dart';
import 'package:waijudi/model/categroy.dart';

class ApiClient {
  static final _client = ApiClient._internal();
  final _http = http.Client();

  ApiClient._internal();

  final String baseUrl = 'waijudi.ywhuilong.com';
  final Map<String, String> _headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'token': '14f2e846-6b31-460b-9ebc-34006a0ce0b1' //TODO: renew token
  };

  factory ApiClient() => _client;

  Future<dynamic> _post (Uri uri, { Map? params }) async {
    var body = params != null ? 'params=${sign(params)}' : '';
    var response = await _http.post(uri, headers: {
      ..._headers,
      'Content-Length': body.length.toString()
    }, body: body);
    var decodedResponse = ApiResponse.fromJson(jsonDecode(utf8.decode(response.bodyBytes)) as Map);
    if (decodedResponse.code == 1) {
      return decodedResponse.data;
    } else {
      throw Exception(decodedResponse.msg);
    }
  }

  Future<SearchResult> getVideo (
      {int page = 1, int category = 0, int pageSize = 6}) async {
    var url = Uri.https(baseUrl, '/web/video_home/getVideo');
    var params = {'type_id': category, 'page': page, 'pageSize': pageSize};

    return _post(url, params: params).then((data) => SearchResult.fromJson(data));
  }

  Future<List<Categroy>> getNavigation (
      {int page = 1, int category = 0, int pageSize = 6}) async {
    var url = Uri.https(baseUrl, '/web/video_home/getNavigation');

    return _post(url).then((data) => (data as List).map((d) => Categroy.fromJson(d)).toList());
  }
}