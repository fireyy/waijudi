import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/organic_button.dart';

class Details extends StatelessWidget {
  final DetailController controller = Get.find();

  Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),        
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(bottom: 25),
              margin: const EdgeInsets.only(bottom: 25),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.LIGHT,
                    width: 1,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Obx(
                    () => Text(
                      controller.appController.video.name,
                      style: TextStyle(
                        fontSize: 32,
                        color: AppColors.DARK,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => Text(
                      controller.appController.video.vodActor ?? "",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.DARK,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Obx(
                    () => Text(
                      controller.appController.video.vodRemarks,
                      style: TextStyle(
                        fontSize: 32,
                        color: AppColors.LIGHT_GREEN,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ),
                ),
                Expanded(
                  child: OrganicButton(
                    () => controller.watch(), // play action
                    "Watch",
                    Icons.play_arrow,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
