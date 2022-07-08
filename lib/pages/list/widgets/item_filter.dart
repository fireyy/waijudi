import 'package:flutter/material.dart';
import 'package:waijudi/models/filter.dart';
import 'package:waijudi/pages/list/controller.dart';
import 'package:waijudi/util/colors.dart';
import 'package:get/get.dart';

class ItemFilter extends StatelessWidget {
  final ListController controller = Get.find();
  final Filter filter;
  final bool selected;
  VoidCallback onPressed;

  ItemFilter(this.filter, this.selected, this.onPressed, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Text(filter.name);
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(filter.name, style: TextStyle(
          fontSize: 12,
          color: selected ? AppColors.GREEN : AppColors.DARK,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
        )),
      )
    );
  }
}
