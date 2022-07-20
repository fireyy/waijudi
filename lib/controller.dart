import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/util/api_client.dart';
import 'package:waijudi/util/storage.dart';
import 'package:waijudi/util/colors.dart';

class AppController extends GetxController{

  ApiClient apiClient = Get.find();
  Rx<String> _currentApiUrl = Rx<String>('');

  @override
  void onInit() {
    getApiUrl();
    super.onInit();
  }

  getApiUrl () async {
    var result = await apiClient.getUrl();
    if (result.isNotEmpty) Storage.saveApiUrls(result);
  }

  showConfig () {
    var apiUrl = Storage.apiUrls;
    _currentApiUrl.value = Storage.currentApiUrl;
    Get.defaultDialog(
      title: '配置',
      textConfirm: '保存',
      textCancel: '取消',
      confirmTextColor: AppColors.LIGHT,
      barrierDismissible: false,
      radius: 10,
      onConfirm: () async {
        // save config
        Storage.saveCurrentApiUrl(_currentApiUrl.value);
        Get.back();
      },
      content: Container(
        height: 250,
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('选择API地址:'),
            ...(
              apiUrl.map(
                (url) => Obx(() => RadioListTile<String>(
                  title: Text(url),
                  value: url,
                  groupValue: _currentApiUrl.value,
                  onChanged: (String? value) {
                    _currentApiUrl.value = value ?? apiUrl[0];
                  },
                ))
              )
            ),
          ],
        ),
      ),
    );
  }

}