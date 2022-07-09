import 'package:get/get.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/util/storage.dart';

final RegExp _wordBreak = RegExp(r'(^|[\-_ ])(\w)');

String camelCase(String s) =>
    s.replaceAllMapped(_wordBreak, (m) => (m[2] ?? '').toUpperCase());

String lowerCamelCase(String s) {
  String result = camelCase(s);
  result = result.replaceRange(0, 1, s[0].toLowerCase());
  return result;
}

void goToDetail(VideoItem item) {
  Storage.setMemory('videoItem', item);
  Get.toNamed('/detail/${item.id}');
}