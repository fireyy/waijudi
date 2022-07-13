import 'package:get/get.dart';
import 'package:waijudi/util/storage.dart';

// FIXME: not use VideoItem
void goToDetail(String name, Map<String, String> params) {
  Storage.videoName = name;
  Get.toNamed('/detail', parameters: params);
}