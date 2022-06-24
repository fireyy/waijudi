import 'package:flutter_test/flutter_test.dart';
import 'package:waijudi/utils/encrypt.dart';
import 'dart:convert';

void main() {
  test('encrypt sign test', () {
    var params = { 'type_id': 0, 'page': 1, 'pageSize': 6 };
    String str = 'dXSHYhWmrBeyJ0eXBlX2lkIjowLCJwYWdlIjoxLCJwYWdlU2l6ZSI6Nn0=';
    String encryptStr = sign(params);
    expect(encryptStr.substring(10), str.substring(10));
  });
  test('encrypt decode test', () {
    var params = 'mhbwaamepneyJpZCI6MTYsInR5cGUiOjUsInVybCI6Imh0dHBzOlwvXC8xMDA4OGhnLmNvbVwvP3JjPW50bGh5Mnl4eW0iLCJwaWMiOiJodHRwOlwvXC93YWlqdWRpLnl3aHVpbG9uZy5jb21cL3VwbG9hZHNcLzIwMjIwNDI0XC8zYTNhZjA1MDMxNTBkNjY2NDA4ZmYzNjBhNGQ5YTcxYi5qcGciLCJ0aW1lIjpudWxsLCJzdGF0dXMiOjEsImNyZWF0ZXRpbWUiOjE2NDI1MjI1NzQsInVwZGF0ZXRpbWUiOjE2NTE5MjU0NzMsImNvdW50X2Rvd25fdGltZSI6bnVsbCwidHlwZV9pZCI6LTEsInNvcnQiOm51bGx9';
    String decodeStr = decode(params.substring(10));
    expect(jsonDecode(decodeStr)['id'], 16);
  });
}