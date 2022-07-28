import 'package:flutter/material.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/more/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'package:waijudi/pages/home/widgets/item_videos.dart';
import 'package:easy_refresh/easy_refresh.dart';

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreController>(
      init: MoreController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          appBar: CustomAppBar(
            autoLeading: true,
            title: Text(controller.name, style: TextStyle(
              color: AppColors.DARK,
            )),
            actions: [
              CustomAppBarAction(
                () => Get.toNamed('/list'),
                Icons.filter_list,
              ),
            ],
          ),
          body: EasyRefresh(
            refreshOnStart: true,
            onRefresh: () async {
              await controller.refreshData();
            },
            onLoad: () async {
              await controller.loadData();
            },
            child: CustomScrollView(
              slivers: [
                Obx(
                  () {
                    return SliverPadding(
                      padding: const EdgeInsets.all(25),
                      sliver: SliverGrid(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15.0,
                          crossAxisSpacing: 15.0,
                          childAspectRatio: 270 / 383,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return ListItem(controller.searchResults.elementAt(index));
                          },
                          childCount: controller.searchResults.length,
                        ),
                      ),
                    );
                  }
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}