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
import 'package:waijudi/widgets/loading.dart';
import 'package:waijudi/widgets/empty_tip.dart';

class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  final searchController = TextEditingController();

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
            }, controller: searchController),
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
                  if (controller.isLoading.value) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Loading(),
                      ],
                    );
                  } else if (controller.searchResults.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('热门搜索', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: [
                              ...(
                                controller.hotKeywords.map(
                                  (keyword) => GestureDetector(
                                    onTap: () {
                                      searchController.text = keyword;
                                      controller.search(keyword);
                                    },
                                    child: Text(keyword),
                                  )
                                )
                              )
                            ],
                          ),
                          !controller.isInitialized.value ? const EmptyTip() : const SizedBox(),
                        ],
                      )
                    );
                  } else {
                    return ListView.builder(
                      physics: physics,
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final VideoItem item = controller.searchResults.elementAt(index);
                        return listVideoItemBuilder(context, item, index);
                      },
                    );
                  }
                }
              );
            },
          ),
        );
      },
    );
  }
}
