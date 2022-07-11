import 'package:flutter/material.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/search/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/search_field.dart';
import 'package:waijudi/widgets/list_video_item.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'package:easy_refresh/easy_refresh.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          appBar: CustomAppBar(
            title: SearchField(autofocus: true, onSubmitted: (value) {
              controller.search(value);
            }),
            actions: [
              CustomAppBarAction(
                () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  Get.back();
                },
                Icons.close,
              ),
            ],
          ),
          body: EasyRefresh.builder(
            noMoreRefresh:true,
            controller: controller.loadController,
            onLoad: () async {
              await controller.searchByName();
            },
            childBuilder: (context, physics) {
              return Obx(
                () {
                  return ListView.builder(
                    physics: physics,
                    itemExtent: 140,
                    itemCount: controller.searchResults.length,
                    itemBuilder: (context, index) {
                      final VideoItem item = controller.searchResults.elementAt(index);
                      return listVideoItemBuilder(context, item, index);
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
