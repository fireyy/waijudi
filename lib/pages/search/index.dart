import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/search/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/search_field.dart';
import 'package:waijudi/widgets/list_video_item.dart';
import 'package:waijudi/models/videoitem.dart';
import 'package:waijudi/widgets/appbar_action.dart';

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
                () => Get.back(),
                Icons.close,
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: <Widget>[
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
