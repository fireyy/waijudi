import 'package:waijudi/util/encrypt.dart';
import 'dart:convert';

class ApiResponse {
  int code;
  String msg;
  String url;
  dynamic data;

  ApiResponse.fromJson(Map jsonMap)
      : code = jsonMap['code'].toInt(),
        msg = jsonMap['msg'].toString(),
        url = jsonMap['url'].toString(),
        data = jsonDecode(decode(jsonMap['data']['response'].substring(10)));
}