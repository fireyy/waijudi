import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/video_image.dart';
import 'package:waijudi/controller.dart';

AppController appController = Get.find();

Widget listVideoItem(BuildContext context, VideoItem item, int index) {
  return GestureDetector(
    onTap: () {
      appController.goToDetail(item);
    },
    child: ListTile(
      leading: VideoImage(
        item.vodPic,
        width: 60,
        height: 80,
        fit: BoxFit.fill,
      ),
      title: Text(
        item.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        item.vodActor ?? '',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Text(
        item.playbackTimes.toString(),
        style: TextStyle(color: AppColors.LIGHT_GREEN),
      ),
      isThreeLine: true,
    ),
  );
}