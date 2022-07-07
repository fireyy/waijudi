import 'package:get/get.dart';
import 'package:waijudi/util/encrypt.dart';
import 'package:get/get_connect/http/src/request/request.dart';

import 'package:waijudi/models/api_response.dart';
import 'package:waijudi/models/searchresult.dart';
import 'package:waijudi/models/category.dart';
import 'package:waijudi/models/line.dart';
import 'package:waijudi/models/drama.dart';
import 'package:waijudi/models/filter.dart';
import 'package:waijudi/util/storage.dart';

class ApiClient extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (json) => ApiResponse.fromJson(json);
    httpClient.baseUrl = 'https://waijudi.ywhuilong.com';
    httpClient.defaultContentType = 'application/x-www-form-urlencoded;charset=utf-8';
    httpClient.timeout = const Duration(seconds: 15);

    addRequestModifier();

    httpClient.addResponseModifier<ApiResponse>((Request request, Response response) {
      Get.log(
        'Status Code: ${response.statusCode}, code=${response.body.code ?? ''}, msg=${response.body.msg ?? ''}\n'
            'Data: ${response.body.data ?? ''}',
      );
      return response;
    });

    httpClient.addResponseModifier<ApiResponse>((Request request, Response response) {
      ApiResponse decodedResponse = response.body ?? ApiResponse();
      if (decodedResponse.code == 1) {
        return response;
      } else if (decodedResponse.code == 2008) {
        request.printError(info: decodedResponse.msg);
        Get.offNamed('/login', parameters: {
          'callback': Get.routing.current
        });
      } else {
        throw Exception(decodedResponse.msg);
      }
    });
    super.onInit();
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      if (Storage.hasData('token')) {
        request.headers['token'] = Storage.getValue('token');
      }
      // request.headers['token'] = '63e6aba8-f7fa-4f1f-b9c9-ab3ee9a8f3d4';
      Get.log(
        'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );

      return request;
    });
  }

  void addAuthenticator (String token) {
    httpClient.addAuthenticator((Request request) async {
      // Set the header
      request.headers['token'] = token;
      return request;
    });
  }

  Future<dynamic> _post (String uri, { Map? params }) async {
    final formData = params != null ? FormData({
      'params': sign(params),
    }): {};
    var response = await post(uri, formData);
    // print(response.body);
    var decodedResponse = response.body;
    if (decodedResponse.code == 1) {
      return decodedResponse.data;
    }
  }

  Future<dynamic> _get (String uri, { Map<String, dynamic>? params }) async {
    var response = await get(uri, query: params == null ?  params : params.map((key, value) => MapEntry(key, value.toString())));
    // print(response.body);
    var decodedResponse = response.body;
    if (decodedResponse.code == 1) {
      return decodedResponse.data;
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

    return _post('/web/search_home/getHodVod', params: params).then((data) => SearchResultWithVideoItem.fromJson(data));
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

  Future<String> login (String mobile, String password) async {
    var params = {'mobile': mobile, 'password': password, 'ip': ''};
    return _post('/web/user/login', params: params).then((data) => data['token']);
  }
  // /web/user/login params=k3xm7yaxQdeyJpcCI6IjguMjE5LjEzMi4xMTEiLCJtb2JpbGUiOiIxODkxNzU2NjgyOSIsInBhc3N3b3JkIjoiemh1YW5sIn0=
  // /web/user_info/personalCenter
  // /web/user_info/playbackRecord
}