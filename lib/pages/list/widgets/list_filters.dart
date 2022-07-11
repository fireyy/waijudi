import 'package:flutter/material.dart';
import 'package:waijudi/models/filter.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'item_filter.dart';

class ListFilters extends StatelessWidget {
  final ListController controller = Get.find();

  ListFilters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: (controller.filters.length * 38),
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5),
          itemCount: controller.filters.length,
          itemBuilder: (_, index) {
            FilterModel filterData = controller.filters.elementAt(index);
            return SizedBox(
              height: 25,
              child: ListView.separated(
                shrinkWrap: true,
                cacheExtent: 25,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (BuildContext context, int idx) => const SizedBox(width: 5),
                itemCount: filterData.list.length,
                itemBuilder: (_, idx) {
                  Filter filter = filterData.list.elementAt(idx);
                  return Obx(
                    () => ItemFilter(
                      filter,
                      controller.filterMap[filterData.name] == filter.id,
                      () => controller.filter({
                        filterData.name: filter.id,
                      }),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    });
  }
}