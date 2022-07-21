import 'package:flutter/material.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/rank/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/list_video_item.dart';
import 'package:waijudi/widgets/list_categories.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:waijudi/pages/rank/widgets/list_rank.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'package:waijudi/widgets/loading.dart';

class RankPage extends GetView<RankController> {
  const RankPage({Key? key}) : super(key: key);

  Future<bool> onRefresh() async {
    await controller.loadCategories();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT,
      appBar: CustomAppBar(
        autoLeading: true,
        title: Text('排行榜', style: TextStyle(color: AppColors.DARK),),
        height: 120,
        actions: [
          CustomAppBarAction(
            () => Get.toNamed('/list'),
            Icons.filter_list,
          ),
        ],
        bottom: Obx(() => Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListRanks(
              ranks: controller.categories.value.rank,
              selectedRank: controller.selectedRank,
              onSelect: controller.selectRank,
            ),
            const SizedBox(height: 10),
            ListCategories(
              categories: controller.categories.value.type,
              selectedCategory: controller.selectedCategory,
              onSelectCategory: controller.selectCategory,
            ),
          ],
        )),
      ),
      body: EasyRefresh(
        noMoreRefresh: true,
        onLoad: () async {
          await controller.loadRankList();
        },
        child: CustomScrollView(
          slivers: [
            Obx(() => controller.isLoading.value ? const SliverToBoxAdapter(child: Loading()) : SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  var data = controller.resultData.elementAt(index);
                  return listVideoItemBuilder(context, data, index, rank: (index + 1));
                },
                childCount: controller.resultData.length,
              )
            )),
          ],
        ),
      ),
    );
  }
}