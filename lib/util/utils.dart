import 'package:get/get.dart';
import 'package:waijudi/util/storage.dart';

// 跳转到详情页面
void goToDetail(String name, Map<String, String> params) {
  Storage.videoName = name;
  Get.toNamed('/detail', parameters: params);
}