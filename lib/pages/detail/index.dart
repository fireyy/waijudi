import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/pages/detail/widgets/player.dart';
import 'package:waijudi/pages/detail/widgets/skeleton.dart';

class VideoDetail extends StatelessWidget {
  const VideoDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: GetBuilder<DetailController>(
        init: DetailController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Obx(() => controller.videoList['video']!.isNotEmpty ? const Player() : const PlayerSkeleton()),
          );
        },
      ),
    );
  }
}
