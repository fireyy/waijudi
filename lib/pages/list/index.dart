import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:waijudi/pages/list/widgets/list_filters.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/list/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/list_video_item.dart';
import 'package:waijudi/models/videoitem.dart';

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
                backgroundColor: AppColors.WHITE,
                title: Text('List', style: TextStyle(color: AppColors.DARK),),
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    var top = constraints.biggest.height;
                      return FlexibleSpaceBar(
                        expandedTitleScale: 1,
                        title: top > 71 && top < 91 ?  Text('List, Today') : ListFilters(),
                      );
                  }
                ),
                expandedHeight: 250,
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
