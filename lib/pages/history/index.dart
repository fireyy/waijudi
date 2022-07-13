import 'package:flutter/material.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/history/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/list_video_item.dart';
import 'package:waijudi/models/playback.dart';
import 'package:easy_refresh/easy_refresh.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryController>(
      init: HistoryController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          appBar: CustomAppBar(
            title: Text('List', style: TextStyle(color: AppColors.DARK),),
            autoLeading: true,
            actions: [
              TextButton(onPressed: () {}, child: Text('Edit', style: TextStyle(color: AppColors.DARK),)),
            ],
          ),
          body: EasyRefresh.builder(
            refreshOnStart: true,
            controller: controller.loadController,
            onRefresh: () async {
              await controller.refreshData();
            },
            onLoad: () async {
              await controller.loadData();
            },
            childBuilder: (context, physics) {
              return Obx(
                () {
                  return ListView.builder(
                    physics: physics,
                    itemExtent: 140,
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final Playback item = controller.searchResults.elementAt(index);
                      return listPlaybackBuilder(context, item, index);
                    },
                  );
                }
              );
            },
          ),
        );
      },
    );
  }
}
