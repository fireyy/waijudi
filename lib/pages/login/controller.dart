import 'package:get/get.dart';
import 'package:waijudi/controller.dart';
import 'package:waijudi/util/storage.dart';

class LoginController extends GetxController {
  AppController appController = Get.find();
  Storage settings = Get.find();
  final RxBool _passwordVisible = RxBool(false);
  set passwordVisible(bool value) => _passwordVisible.value = value;
  bool get passwordVisible {
    return _passwordVisible.value;
  }
  final RxString _mobile = RxString('');
  set mobile(String value) => _mobile.value = value;
  final RxString _password = RxString('');
  set password(String value) => _password.value = value;

  LoginController() {
    //
  }

  login() async {
    // print('======================${_mobile.value}, ${_password.value}');
    final token = await appController.apiClient.login(_mobile.value, _password.value);
    if (token != '') {
      settings.token.setValue(token);
      appController.apiClient.token = token;
      Get.offNamed('/');
    }
  }
}
