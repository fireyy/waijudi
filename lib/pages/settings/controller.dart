import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:waijudi/util/storage.dart';
import 'package:waijudi/util/utils.dart';

class SettingsController extends GetxController {
  AppController appController = Get.find();
  final Rx<String> _currentApiUrl = Rx<String>('');
  String get currentApiUrl => _currentApiUrl.value;
  final appName = ''.obs;
  final version = ''.obs;
  final buildNumber = ''.obs;
  final apiUrl = <String>[].obs;

  SettingsController() {
    getPackageInfo();
    getApiUrl();
  }

  getPackageInfo () async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appName.value = packageInfo.appName;
    version.value = packageInfo.version;
    buildNumber.value = packageInfo.buildNumber;
  }

  setCurrentApiUrl (String? value) {
    _currentApiUrl.value = value ?? apiUrl[0];
  }

  onSave () async {
    // save config
    await Storage.saveCurrentApiUrl(_currentApiUrl.value);
    toast('保存成功');
  }

  getApiUrl () async {
    try {
      apiUrl.value = Storage.apiUrls;
      _currentApiUrl.value = Storage.currentApiUrl;
      var result = await appController.apiClient.getUrl();
      if (!listEquals(result, apiUrl)) {
        Storage.saveApiUrls(result);
      }
    } catch (err) {
      //
    }
  }
}
