import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:waijudi/pages/list/widgets/list_filters.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/list/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/list_video_item.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/widgets/appbar_action.dart';

class List extends StatelessWidget {
  const List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListController>(
      init: ListController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          body: CustomScrollView(
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
                      title: top > 91 && top < 111 ? Padding(padding: const EdgeInsets.only(bottom: 5), child: Text(filterName.join('·'), style: TextStyle(fontSize: 14, color: AppColors.DARK))) : ListFilters(),
                    );
                  }
                ),
                expandedHeight: 250,
                collapsedHeight: 80,
              ),
              PagedSliverList<int, VideoItem>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<VideoItem>(
                  itemBuilder: listVideoItem,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
