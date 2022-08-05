import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/util/storage.dart';

// 跳转到详情页面
void goToDetail(String name, Map<String, String> params) {
  Storage.videoName = name;
  Get.toNamed('/detail', parameters: params);
}

// toast
void toast(String text) {
  Get.rawSnackbar(
    messageText: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      )
    ),
    padding: const EdgeInsets.all(10),
    shouldIconPulse: false,
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Colors.black.withAlpha(150),
    snackStyle: SnackStyle.FLOATING,
    maxWidth: Get.width * 0.5,
    borderRadius: 6
  );
}