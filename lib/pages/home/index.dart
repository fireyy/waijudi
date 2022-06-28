import 'package:flutter/material.dart';
import 'package:waijudi/widgets/custom_appbar.dart';
import 'package:get/get.dart';
import 'package:waijudi/pages/home/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:waijudi/widgets/appbar_action.dart';
import 'widgets/list_sections.dart';
import 'widgets/list_categories.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.LIGHT,
          appBar: CustomAppBar(
            "Waijudi",
            actions: [
              CustomAppBarAction(
                () => controller.loadCategories(),
                Icons.filter_list_alt,
              ),
            ],
          ),
          body: CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: ListCategories(),
              ),
              ListSections(),
            ],
          ),
        );
      },
    );
  }
}
