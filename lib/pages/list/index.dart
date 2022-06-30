import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:waijudi/pages/list/widgets/list_filters.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:waijudi/widgets/appbar_action.dart';
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
          appBar: CustomAppBar(
            title: const Text('List'),
            leading: CustomAppBarAction(
              () => Get.back(),
              Icons.arrow_back,
            ),
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: ListFilters(),
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
