import 'package:flutter_test/flutter_test.dart';
import 'package:waijudi/util/utils.dart';

void main() {
  test('camelCase test', () {
    expect(camelCase('test_case'), 'TestCase');
    expect(camelCase('test-case'), 'TestCase');
    expect(camelCase('test case'), 'TestCase');
  });
  test('lowerCamelCase test', () {
    expect(lowerCamelCase('Test_case'), 'testCase');
    expect(lowerCamelCase('Test-case'), 'testCase');
    expect(lowerCamelCase('Test case'), 'testCase');
  });
}