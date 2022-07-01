import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'routes.dart';
import 'util/colors.dart';
import 'package:waijudi/util/api_client.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:waijudi/util/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final preferences = await StreamingSharedPreferences.instance;
  final settings = Storage(preferences);
  Get.put(settings);
  Get.put(ApiClient());
  runApp(MyApp(settings));
}

class MyApp extends StatelessWidget {
  const MyApp(this.settings, {Key? key}) : super(key: key);
  final Storage settings;
  @override
  Widget build(BuildContext context) {
    Get.put(AppController());

    return PreferenceBuilder<String>(
      preference: settings.token,
      builder: (BuildContext context, String token) {
        final isLogin = token != '';

        return GetMaterialApp(
          title: 'Waijudi',
          theme: ThemeData(
            primarySwatch: AppColors.WHITE,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: isLogin ? "/" : '/login',
          getPages: routes(),
        );
      },
    );
  }
}