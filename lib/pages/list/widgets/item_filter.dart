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
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(0),
        minimumSize: const Size.fromWidth(30),
      ),
      child: Text(
        filter.name,
        style: TextStyle(
          fontSize: 14,
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: AppColors.DARK.withOpacity(selected ? 1 : 0.6),
        ),
      ),
    );
  }
}
