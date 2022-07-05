import 'package:get/get.dart';
import 'package:waijudi/util/encrypt.dart';

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
    // httpClient.defaultDecoder = (json) => ApiResponse.fromJson(json);
    httpClient.baseUrl = 'https://waijudi.ywhuilong.com';
    httpClient.defaultContentType = 'application/x-www-form-urlencoded;charset=utf-8';
    httpClient.timeout = const Duration(seconds: 15);

    addRequestModifier();

    httpClient.addResponseModifier((request, response) {
      printInfo(
        info: 'Status Code: ${response.statusCode}\n'
            'Data: ${response.bodyString?.toString() ?? ''}',
      );
      return response;
    });
    super.onInit();
  }

  void addRequestModifier() {
    httpClient.addRequestModifier<dynamic>((request) {
      if (Storage.hasData('token')) {
        request.headers['token'] = Storage.getValue('token');
      }
      // request.headers['token'] = '63e6aba8-f7fa-4f1f-b9c9-ab3ee9a8f3d4';
      printInfo(
        info: 'REQUEST ║ ${request.method.toUpperCase()}\n'
            'url: ${request.url}\n'
            'Headers: ${request.headers}\n'
            'Body: ${request.files?.toString() ?? ''}\n',
      );

      return request;
    });
  }

  Future<dynamic> _post (String uri, { Map? params }) async {
    final formData = params != null ? FormData({
      'params': sign(params),
    }): {};
    var response = await post(uri, formData);
    // print(response.body);
    var decodedResponse = ApiResponse.fromJson(response.body);
    if (decodedResponse.code == 1) {
      return decodedResponse.data;
    } else if (decodedResponse.code == 2008) {
      Get.offNamed('/login');
    } else {
      throw Exception(decodedResponse.msg);
    }
  }

  Future<dynamic> _get (String uri, { Map<String, dynamic>? params }) async {
    var response = await get(uri, query: params ?? {});
    // print(response.body);
    var decodedResponse = ApiResponse.fromJson(response.body);
    if (decodedResponse.code == 1) {
      return decodedResponse.data;
    } else if (decodedResponse.code == 2008) {
      Get.offNamed('/login');
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

  Future<String> login (String mobile, String password) async {
    var params = {'mobile': mobile, 'password': password, 'ip': ''};
    return _post('/web/user/login', params: params).then((data) => data['token']);
  }
  // /web/user/login params=k3xm7yaxQdeyJpcCI6IjguMjE5LjEzMi4xMTEiLCJtb2JpbGUiOiIxODkxNzU2NjgyOSIsInBhc3N3b3JkIjoiemh1YW5sIn0=
  // /web/user_info/personalCenter
  // /web/user_info/playbackRecord
}