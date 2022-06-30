import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/organic_button.dart';
import 'package:waijudi/widgets/line_button.dart';
import 'package:waijudi/models/drama.dart';
import 'package:waijudi/models/line.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailController controller = Get.find();
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
                        fontSize: 26,
                        color: AppColors.DARK,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => controller.lines.length > 1 ? SizedBox(
                      height: 35,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10),
                        itemCount: controller.lines.length,
                        itemBuilder: (_, index) {
                          LineModel line = controller.lines.elementAt(index);
                          return Obx(() {
                            return LineButton(
                              line.name,
                              () => controller.selectLine(line.vodLineId),
                              controller.selectedLineId.value == line.vodLineId,
                            );
                          });
                        },
                      ),
                    ) : const SizedBox(height: 15),
                  ),
                  const SizedBox(height: 15),
                  Obx(
                    () => SizedBox(
                      height: 35,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 10),
                        itemCount: controller.drama.length,
                        itemBuilder: (_, index) {
                          Drama drama = controller.drama.elementAt(index);
                          return Obx(() {
                            return LineButton(
                              drama.dramaName,
                              () => controller.selectEpisode(index),
                              controller.selectedDrama.value == index
                            );
                          });
                        },
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
                        fontSize: 20,
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
