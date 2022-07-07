import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/pages/detail/widgets/player.dart';

class VideoDetail extends StatelessWidget {
  const VideoDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      init: DetailController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          body: SingleChildScrollView(
            child: Obx(() => controller.videoList['video']!.isNotEmpty ? const Player() : const Text('loading...')),
          ),
        );
      },
    );
  }
}
