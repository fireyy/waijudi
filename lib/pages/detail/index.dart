import 'package:flutter/material.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/video_image.dart';
import 'widgets/details.dart';

class VideoDetail extends StatelessWidget {
  const VideoDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          appBar: CustomAppBar(
            "Product",
            leadings: [
              CustomAppBarAction(
                () => Get.back(),
                Icons.arrow_back,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Obx(
                  () => VideoImage(
                    controller.appController.video.vodPic,
                    height: Get.width - 50,
                    padding: 25,
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Obx(() => Details(controller.appController.video)),
        );
      },
    );
  }
}
