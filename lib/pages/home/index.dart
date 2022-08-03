import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/home/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'package:waijudi/pages/home/widgets/list_sections.dart';
import 'package:waijudi/widgets/list_categories.dart';
import 'package:waijudi/widgets/search_field.dart';
import 'package:easy_refresh/easy_refresh.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.LIGHT,
      appBar: CustomAppBar(
        title: SearchField(onTap: () {
          Get.toNamed('/search');
        }),
        actions: [
          CustomAppBarAction(
            () => Get.toNamed('/rank'),
            Icons.insights,
          ),
          CustomAppBarAction(
            () => Get.toNamed('/settings'),
            Icons.tune_outlined,
          ),
        ],
        height: 85,
        bottom: Obx(() => ListCategories(
          categories: controller.categories, 
          selectedCategory: controller.selectedCategory,
          onSelectCategory: controller.selectCategory,
        )),
      ),
      body: EasyRefresh(
        refreshOnStart: true,
        noMoreLoad: true,
        onRefresh: () async {
          // 震动反馈
          HapticFeedback.lightImpact();
          await controller.loadCategories();
          return IndicatorResult.success;
        },
        child: CustomScrollView(
          slivers: [
            Obx(() {
              return SliverList(delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var section = controller.homeData[index];
                    return ListSections(section, handleMore: (id, name) {
                      Get.toNamed('/more', parameters: {
                        'id': '${id == 0 ? controller.selectedCategory.id : id}',
                        'name': name,
                      });
                    });
                  },
                  childCount: controller.homeData.length,
                ),
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/history'),
        backgroundColor: AppColors.LIGHT_GREEN,
        child: Icon(Icons.access_time, color: AppColors.LIGHT),
      ),
    );
  }
}