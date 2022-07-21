import 'package:get/get.dart';

import './controller.dart';

class RankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RankController>(
      () => RankController(),
    );
  }
}