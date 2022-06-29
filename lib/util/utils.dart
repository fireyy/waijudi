final RegExp _wordBreak = RegExp(r'(^|[\-_ ])(\w)');

String camelCase(String s) =>
    s.replaceAllMapped(_wordBreak, (m) => (m[2] ?? '').toUpperCase());

String lowerCamelCase(String s) {
  String result = camelCase(s);
  result = result.replaceRange(0, 1, s[0].toLowerCase());
  return result;
}