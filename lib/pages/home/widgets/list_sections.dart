import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/pages/home/controller.dart';
import 'list_videos.dart';

class ListSections extends StatelessWidget {
  final HomeController controller = Get.find();
  ListSections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SliverList(delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          var section = controller.homeData[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  left: 25,
                  right: 25,
                  bottom: 10,
                ),
                child: Text(section.name, style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.DARK,
                ))
              ),
              HomeList(section.video)
            ]
          );
        },
        childCount: controller.homeData.length,
      ));
    });
  }
}