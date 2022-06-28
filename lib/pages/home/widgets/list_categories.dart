import 'package:flutter/material.dart';
import 'package:waijudi/models/category.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'item_categories.dart';

class ListCategories extends StatelessWidget {
  final HomeController controller = Get.find();

  ListCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 100,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 20),
          itemCount: controller.categories.length,
          itemBuilder: (_, index) {
            Category category = controller.categories.elementAt(index);
            return Obx(() {
              return ItemCategories(
                category,
                category == controller.selectedCategory,
              );
            });
          },
        ),
      );
    });
  }
}
