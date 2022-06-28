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
  test('api_client vodDecrypt test', () async {
    var result = await _apiClient.vodDecrypt('https://fangao.dujsxx.com/concat/20220218/c82b7ff1ab604eeea65e64913c255492/cloudv-transfer/55555555sp900r7p5556s265p29s52p5_ce75d19d1b2d4d69887843bfdd966a1a_0_3.m3u8');
    expect(result.contains('wsSecret='), true);
  });
}