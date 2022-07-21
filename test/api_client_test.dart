import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:waijudi/util/api_client.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ApiClient apiClient = ApiClient();
 
  test('api_client options', () async {
    expect(apiClient.http.options.baseUrl, 'https://waijudi.ywhuilong.com');
    expect(apiClient.http.options.contentType, Headers.formUrlEncodedContentType);
  });
}