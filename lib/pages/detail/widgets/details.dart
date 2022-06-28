import 'package:flutter/material.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/detail/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/organic_button.dart';

class Details extends StatelessWidget {
  final DetailController controller = Get.find();
  final VideoItem video;

  Details(this.video, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: AppColors.WHITE,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),        
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 25),
              margin: EdgeInsets.only(bottom: 25),
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
                      video.name ?? "",
                      style: TextStyle(
                        fontSize: 32,
                        color: AppColors.DARK,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Obx(
                    () => Text(
                      video.vodActor ?? "",
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
                  child: Text(
                    video.vodRemarks,
                    style: TextStyle(
                      fontSize: 32,
                      color: AppColors.LIGHT_GREEN,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: OrganicButton(
                    () => '', // play action
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
