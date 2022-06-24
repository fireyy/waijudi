import 'package:flutter_test/flutter_test.dart';
import 'package:waijudi/util/api_client.dart';

ApiClient _apiClient = ApiClient();

void main() {
  test('api_client getVideo test', () async {
    var result = await _apiClient.getVideo();
    expect(result.data[0].name, '猜你喜欢');
  });
  test('api_client getNavigation test', () async {
    var result = await _apiClient.getNavigation();
    expect(result[0].name, '推荐');
  });
}