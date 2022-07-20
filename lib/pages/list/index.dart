import 'package:flutter/material.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:waijudi/pages/list/widgets/list_filters.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/list/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/list_video_item.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'package:waijudi/widgets/loading.dart';
import 'package:waijudi/widgets/empty_tip.dart';

class List extends StatelessWidget {
  const List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListController>(
      init: ListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          body: EasyRefresh(
            noMoreRefresh:true,
            controller: controller.loadController,
            onLoad: () async {
              await controller.searchByFilter();
            },
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  stretch: true,
                  elevation: 0,
                  actions: [
                    CustomAppBarAction(
                      () => Get.toNamed('/search'),
                      Icons.search,
                    ),
                  ],
                  iconTheme: IconThemeData(color: AppColors.DARK),
                  backgroundColor: AppColors.WHITE,
                  title: Text('List', style: TextStyle(color: AppColors.DARK),),
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      var top = constraints.biggest.height;
                      var filterName = [];
                      var filterMap = Map.from(controller.filterMap)..removeWhere((k, v) => v == '0');
                      for (var f in controller.filters) {
                        if (filterMap.keys.contains(f.name)) {
                          for (var l in f.list) {
                            if (l.id == filterMap[f.name]) {
                              filterName.add(l.name);
                            }
                          }
                        }
                      }
                      return FlexibleSpaceBar(
                        expandedTitleScale: 1,
                        titlePadding: const EdgeInsets.only(top: 60),
                        title: 
                          top > 91 && top < 131 ? GestureDetector(
                            onTap: () => controller.goToTop(),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Text(
                                filterName.join('·'),
                                style: TextStyle(fontSize: 14, color: AppColors.DARK)
                              )
                            )
                          ) : ListFilters(),
                        // Text('$top', style: TextStyle(fontSize: 14, color: AppColors.DARK)),
                      );
                    }
                  ),
                  expandedHeight: 240,
                  collapsedHeight: 80,
                ),
                Obx(
                  () {
                    return 
                      controller.isLoading.value ? SliverToBoxAdapter(child: Loading()) : controller.searchResults.isEmpty ? SliverToBoxAdapter(child: EmptyTip()) : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final VideoItem item = controller.searchResults.elementAt(index);
                          return listVideoItemBuilder(context, item, index);
                        },
                        childCount: controller.searchResults.length,
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
