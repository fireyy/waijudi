import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller.dart';
import 'routes.dart';
import 'util/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Get.put(AppController());

    return GetMaterialApp(
      title: 'Waijudi',
      theme: ThemeData(
        primarySwatch: AppColors.WHITE,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/",
      getPages: routes(),
    );
  }
}