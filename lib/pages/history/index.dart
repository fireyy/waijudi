import 'package:flutter/material.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/history/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/list_video_checkbox.dart';
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
            title: Text('观看历史', style: TextStyle(color: AppColors.DARK),),
            autoLeading: true,
            actions: [
              Obx(() {
                return TextButton(
                  onPressed: () => controller.isEdit = !controller.isEdit,
                  child: Text(
                    controller.isEdit ? '取消' : '管理',
                    style: TextStyle(color: AppColors.DARK),
                  )
                );
              })
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
                      return Obx(
                        () {
                          final CheckboxParams params = CheckboxParams(
                            isChecked: controller.selected.contains(item.id),
                            isShowCheckbox: controller.isEdit,
                            onChecked: (id, value) {
                              controller.toggleSelected(id, value);
                            },
                            onDismissed: (String direction) {
                              if (direction == 'select') {
                                controller.isEdit = true;
                                controller.toggleSelected(item.id, true);
                              } else if (direction == 'delete') {
                                controller.removeSinglePlayback(item.id);
                              }
                            }
                          );
                          return listPlaybackBuilder(context, item, index, params);
                        }
                      );
                    },
                  );
                }
              );
            },
          ),
          bottomNavigationBar: Obx(
            () {
              var isNotEmpty = controller.selected.isNotEmpty;
              return Visibility(
                visible: controller.isEdit,
                child: SafeArea(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: AppColors.LIGHT,
                    child: Row(
                      children: [
                        Checkbox(
                          value: isNotEmpty,
                          onChanged: (bool? value) {
                            if (value!) {
                              controller.selected.value = controller.searchResults.map((item) => item.id).toList();
                            } else {
                              controller.selected.clear();
                            }
                          },
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '已选择 ${controller.selected.length} 项',
                            style: TextStyle(color: AppColors.DARK),
                          ),
                        ),
                        TextButton(
                          onPressed: () => isNotEmpty ? controller.confirmToDeletePlaybackRecords() : null,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(isNotEmpty ? AppColors.LIGHT_GREEN : AppColors.LIGHT_GREY),
                          ),
                          child: Text('删除', style: TextStyle(color: AppColors.LIGHT),),
                        ),
                      ],
                    ),
                  )
                ),
              );
            }
          ),
        );
      },
    );
  }
}
