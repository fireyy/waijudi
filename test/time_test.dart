import 'package:flutter_test/flutter_test.dart';
import 'package:waijudi/util/time.dart';

void main() {
  test('timeToSecond test', () {
    expect(timeToSecond(const Duration(seconds: 9, microseconds: 960000)), 9.96);
    expect(timeToSecond(const Duration(hours: 1, minutes: 1, seconds: 42, microseconds: 492000)), 3702.492);
    expect(timeToSecond(const Duration(microseconds: 123456)), 0.123456);
  });
}