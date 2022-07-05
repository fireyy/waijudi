import 'package:flutter/material.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/home/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'package:waijudi/pages/home/widgets/list_sections.dart';
import 'package:waijudi/pages/home/widgets/list_categories.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';

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
        actions: [
          CustomAppBarAction(
            () => Get.toNamed('/search'),
            Icons.search,
          ),
          CustomAppBarAction(
            () => Get.toNamed('/list'),
            Icons.filter_list_alt,
          ),
        ],
      ),
      body: PullToRefreshNotification(
        color: Colors.blue,
        pullBackOnRefresh: true,
        onRefresh: onRefresh,
        child: CustomScrollView(
          physics: const AlwaysScrollableClampingScrollPhysics(),
          slivers: <Widget>[
            PullToRefreshContainer(buildPulltoRefreshImage),
            SliverToBoxAdapter(
              child: ListCategories(),
            ),
            ListSections(),
          ],
        ),
      ),
    );
  }

  Widget buildPulltoRefreshImage(PullToRefreshScrollNotificationInfo? info) {
    final double offset = info?.dragOffset ?? 0.0;
    Widget refreshWidget = Container();
    if (info?.refreshWidget != null &&
         offset > 18.0) {
      refreshWidget = info?.refreshWidget ?? Container();
    }

    return SliverToBoxAdapter(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                refreshWidget,
              ],
            ),
          )
        ],
      ),
    );
  }
}
