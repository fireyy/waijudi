import 'package:flutter/material.dart';
import 'package:waijudi/models/category.dart';
import 'package:waijudi/pages/home/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:get/get.dart';

class ItemCategories extends StatelessWidget {
  final HomeController controller = Get.find();
  final Category category;
  final bool selected;

  ItemCategories(this.category, this.selected, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectCategory(category),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            category.name,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: selected ? AppColors.LIGHT_GREEN : AppColors.DARK.withOpacity(0.3),
            ),
          ),
          Visibility(
            visible: selected,
            child: Container(
              margin: const EdgeInsets.only(top: 3),
              width: 32,
              height: 3,
              decoration: BoxDecoration(
                color: AppColors.LIGHT_GREEN,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
