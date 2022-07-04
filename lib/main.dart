import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'routes.dart';
import 'util/colors.dart';
import 'package:waijudi/util/api_client.dart';
import 'package:get_storage/get_storage.dart';
import 'package:waijudi/util/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLogin = Storage.hasData('token');
    return GetMaterialApp(
      title: 'Waijudi',
      theme: ThemeData(
        primarySwatch: AppColors.WHITE,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: BindingsBuilder(
        () {
          Get.put(ApiClient());
          Get.put(AppController());
        },
      ),
      initialRoute: isLogin ? "/" : '/login',
      getPages: routes(),
    );
  }
}