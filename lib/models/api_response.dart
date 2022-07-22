import 'package:waijudi/util/encrypt.dart';
import 'dart:convert';

class ApiResponse {
  int code;
  String msg;
  String? url;
  dynamic data;

  ApiResponse({this.code = 1, this.msg = ''});

  toJson() {
    return {
      'code': code,
      'msg': msg,
      'url': url,
      'data': data,
    };
  }

  ApiResponse.fromJson(Map jsonMap)
      : code = jsonMap['code'].toInt(),
        msg = jsonMap['msg'].toString(),
        url = (jsonMap['url'] ?? '').toString(),
        data = jsonMap['data'] != null ? jsonDecode(decode(jsonMap['data']['response'].substring(10))) : {};
}