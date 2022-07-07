import 'package:flutter/material.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/home/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'package:waijudi/pages/home/widgets/list_sections.dart';
import 'package:waijudi/pages/home/widgets/list_categories.dart';
import 'package:waijudi/widgets/pull_to_refresh.dart';
import 'package:waijudi/widgets/search_field.dart';

class Home extends GetView<HomeController> {
  const Home({Key? key}) : super(key: key);

  Future<bool> onRefresh() async {
    await controller.loadCategories();
    return true;
  }

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
            () => Get.toNamed('/list'),
            Icons.filter_list_alt,
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        animSpeedFactor: 1.5,
        springAnimationDurationInMilliseconds: 500,
        onRefresh: onRefresh,
        showChildOpacityTransition: false,
        backgroundColor: AppColors.LIGHT,
        color: AppColors.SHADOW,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: ListCategories(),
            ),
            ListSections(),
          ],
        ),
      ),
    );
  }
}